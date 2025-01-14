using System.Data;
using System.Data.SQLite;
using System.Text;

class ETLProcess
{
    static void Main(string[] args)
    {
        Console.WriteLine("Start Program.");

        // Connecting to the OLTP database
        string sourceConnectionString = "Data Source=oltp_database.db;Version=3;";
        // Connecting to the OLAP database
        string destinationConnectionString = "Data Source=olap_database.db;Version=3;";

        // Extracting data from OLTP database
        DataTable ordersData = ExtractData(sourceConnectionString, "SELECT * FROM Orders");
        DataTable subscriptionsData = ExtractData(sourceConnectionString, "SELECT * FROM Subscriptions");
        DataTable developersData = ExtractData(sourceConnectionString, "SELECT COALESCE(OrderDate, '1900-01-01') AS OrderDate, * FROM Orders");

        // Transforming data (e.g., aggregation)
        DataTable factOrdersData = TransformFactOrders(ordersData);
        DataTable factSubscriptionsData = TransformFactSubscriptions(subscriptionsData);

        // Exporting transformed data to CSV
        Console.WriteLine("Start exporting to CSV.");
        ExportDataToCSV(factOrdersData, "FactOrders.csv");
        ExportDataToCSV(factSubscriptionsData, "FactSubscriptions.csv");
        ExportDataToCSV(developersData, "Developers.csv");
        Console.WriteLine("Exporting to CSV completed successfully!");

        // Loading data into the OLAP database
        Console.WriteLine("Start ETL process.");
        LoadDataToOLAP(destinationConnectionString, "FactOrders", factOrdersData);
        LoadDataToOLAP(destinationConnectionString, "FactSubscriptions", factSubscriptionsData);
        LoadDeveloperHistoryToOLAP(destinationConnectionString, "DeveloperHistory", developersData);
        Console.WriteLine("ETL process completed successfully!");

        Console.WriteLine("Program Finished. Thank you!");
    }

    // Extracting data from SQLite database
    static DataTable ExtractData(string connectionString, string query)
    {
        DataTable dataTable = new DataTable();

        using (SQLiteConnection conn = new SQLiteConnection(connectionString))
        {
            conn.Open();
            using (SQLiteDataAdapter dataAdapter = new SQLiteDataAdapter(query, conn))
            {
                dataAdapter.Fill(dataTable);
            }
        }

        return dataTable;
    }

    // Transforming data for FactOrders (aggregation with JOIN to get price)
    static DataTable TransformFactOrders(DataTable ordersData)
    {
        DataTable factOrders = new DataTable();
        factOrders.Columns.Add("FactOrderID", typeof(int));
        factOrders.Columns.Add("UserID", typeof(int));
        factOrders.Columns.Add("ProductID", typeof(int));
        factOrders.Columns.Add("TotalQuantity", typeof(int));
        factOrders.Columns.Add("TotalAmount", typeof(decimal));
        factOrders.Columns.Add("OrderMonth", typeof(int));
        factOrders.Columns.Add("OrderYear", typeof(int));

        // Creating a temporary table to join with the Products table (getting price)
        using (SQLiteConnection conn = new SQLiteConnection("Data Source=oltp_database.db;Version=3;"))
        {
            conn.Open();

            // SQL query with JOIN to get the product price
            string query = @"
            SELECT o.UserID, o.ProductID, o.Quantity, p.Price, strftime('%m', o.OrderDate) AS OrderMonth, strftime('%Y', o.OrderDate) AS OrderYear
            FROM Orders o
            JOIN Products p ON o.ProductID = p.ProductID";

            SQLiteDataAdapter dataAdapter = new SQLiteDataAdapter(query, conn);
            DataTable ordersWithPrice = new DataTable();
            dataAdapter.Fill(ordersWithPrice);

            // Aggregating data
            var grouped = ordersWithPrice.AsEnumerable()
                .GroupBy(row => new { UserID = row["UserID"], ProductID = row["ProductID"], OrderMonth = row["OrderMonth"], OrderYear = row["OrderYear"] })
                .Select(g => new
                {
                    g.Key.UserID,
                    g.Key.ProductID,
                    g.Key.OrderMonth,
                    g.Key.OrderYear,
                    TotalQuantity = g.Sum(x => Convert.ToInt32(x["Quantity"])),
                    TotalAmount = g.Sum(x => Convert.ToInt32(x["Quantity"]) * Convert.ToDecimal(x["Price"]))
                });

            foreach (var row in grouped)
            {
                factOrders.Rows.Add(null, row.UserID, row.ProductID, row.TotalQuantity, row.TotalAmount, row.OrderMonth, row.OrderYear);
            }
        }

        return factOrders;
    }

    // Transforming data for FactSubscriptions (aggregation)
    static DataTable TransformFactSubscriptions(DataTable subscriptionsData)
    {
        DataTable factSubscriptions = new DataTable();
        factSubscriptions.Columns.Add("FactSubscriptionID", typeof(int));
        factSubscriptions.Columns.Add("UserID", typeof(int));
        factSubscriptions.Columns.Add("SubscriptionType", typeof(string));
        factSubscriptions.Columns.Add("TotalSubscriptions", typeof(int));
        factSubscriptions.Columns.Add("StartYear", typeof(int));
        factSubscriptions.Columns.Add("EndYear", typeof(int));

        // Example of aggregation for subscriptions
        var grouped = subscriptionsData.AsEnumerable()
            .GroupBy(row => new { UserID = row["UserID"], SubscriptionType = row["SubscriptionType"] })
            .Select(g => new
            {
                g.Key.UserID,
                g.Key.SubscriptionType,
                TotalSubscriptions = g.Count(),
                StartYear = g.Min(x => Convert.ToDateTime(x["StartDate"]).Year),
                EndYear = g.Max(x => Convert.ToDateTime(x["EndDate"]).Year)
            });

        foreach (var row in grouped)
        {
            factSubscriptions.Rows.Add(null, row.UserID, row.SubscriptionType, row.TotalSubscriptions, row.StartYear, row.EndYear);
        }

        return factSubscriptions;
    }

    // Exporting data to CSV
    static void ExportDataToCSV(DataTable dataTable, string fileName)
    {
        StringBuilder sb = new StringBuilder();

        // Adding column names as the first row
        string[] columnNames = dataTable.Columns.Cast<DataColumn>().Select(column => column.ColumnName).ToArray();
        sb.AppendLine(string.Join(",", columnNames));

        // Adding data rows
        foreach (DataRow row in dataTable.Rows)
        {
            string[] fields = row.ItemArray.Select(field => field.ToString().Replace(",", ";")).ToArray();
            sb.AppendLine(string.Join(",", fields));
        }

        // Writing to file
        File.WriteAllText(fileName, sb.ToString());
        Console.WriteLine($"Data exported to {fileName}");
    }

    // Loading data into OLAP database
    static void LoadDataToOLAP(string connectionString, string tableName, DataTable dataTable)
    {
        using (SQLiteConnection conn = new SQLiteConnection(connectionString))
        {
            conn.Open();
            using (SQLiteTransaction transaction = conn.BeginTransaction())
            {
                foreach (DataRow row in dataTable.Rows)
                {
                    // Forming a list of columns, excluding FactOrderID
                    var columns = dataTable.Columns.Cast<DataColumn>()
                                                    .Where(c => c.ColumnName != "FactOrderID")
                                                    .Select(c => c.ColumnName)
                                                    .ToList();

                    // Forming a list of values, excluding FactOrderID
                    var values = row.ItemArray
                                    .Where((val, index) => dataTable.Columns[index].ColumnName != "FactOrderID")
                                    .Select(val =>
                                    {
                                        if (val == DBNull.Value)
                                        {
                                            return "NULL";  // Converting DBNull to SQL NULL
                                        }

                                        // Escaping single quotes for strings
                                        return val is string ? $"'{val.ToString().Replace("'", "''")}'" : val.ToString();
                                    })
                                    .ToList();

                    // Checking if columns and values are not empty
                    string columnsString = string.Join(",", columns);
                    string valuesString = string.Join(",", values);

                    // Debugging output
                    //Console.WriteLine("Columns: " + columnsString);  // Checking columns
                    //Console.WriteLine("Values: " + valuesString);    // Checking values

                    // Forming an insert query
                    string insertQuery = $"INSERT INTO {tableName} ({columnsString}) VALUES ({valuesString})";

                    // If the query is empty, skip the insert
                    if (string.IsNullOrEmpty(insertQuery))
                    {
                        Console.WriteLine("Error: Generated insertQuery is null or empty.");
                        continue;
                    }

                    // Debugging output for the query
                    //Console.WriteLine("Insert Query: " + insertQuery);

                    using (SQLiteCommand cmd = new SQLiteCommand(insertQuery, conn, transaction))
                    {
                        try
                        {
                            cmd.ExecuteNonQuery(); // Execute the query
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine($"Error executing query: {ex.Message}");  // Print error if query fails
                        }
                    }
                }
                transaction.Commit();
            }
        }
    }

    // Loading data for DeveloperHistory (SCD Type 2)
    static void LoadDeveloperHistoryToOLAP(string connectionString, string tableName, DataTable developersData)
    {
        using (SQLiteConnection conn = new SQLiteConnection(connectionString))
        {
            conn.Open();
            using (SQLiteTransaction transaction = conn.BeginTransaction())
            {
                foreach (DataRow row in developersData.Rows)
                {
                    string insertQuery = $"INSERT INTO {tableName} (DeveloperID, DeveloperName, Country, FoundedYear, StartDate, EndDate, IsCurrent) VALUES (@DeveloperID, @DeveloperName, @Country, @FoundedYear, @StartDate, @EndDate, @IsCurrent)";
                    using (SQLiteCommand cmd = new SQLiteCommand(insertQuery, conn, transaction))
                    {
                        cmd.Parameters.AddWithValue("@DeveloperID", row["DeveloperID"]);
                        cmd.Parameters.AddWithValue("@DeveloperName", row["DeveloperName"]);
                        cmd.Parameters.AddWithValue("@Country", row["Country"]);
                        cmd.Parameters.AddWithValue("@FoundedYear", row["FoundedYear"]);
                        cmd.Parameters.AddWithValue("@StartDate", DateTime.Now);
                        cmd.Parameters.AddWithValue("@EndDate", DBNull.Value);
                        cmd.Parameters.AddWithValue("@IsCurrent", true);
                        cmd.ExecuteNonQuery();
                    }
                }
                transaction.Commit();
            }
        }
    }
}
