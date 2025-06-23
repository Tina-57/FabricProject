[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "SalesLT Customer_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared #"SalesLT Customer" = let
  Source = Sql.Database("tinaserver.database.windows.net", "testdb"),
  #"Navigation 1" = Source{[Schema = "SalesLT", Item = "Customer"]}[Data],
  #"Merged queries" = Table.NestedJoin(#"Navigation 1", {"CustomerID"}, #"SalesLT SalesOrderHeader", {"CustomerID"}, "SalesLT SalesOrderHeader", JoinKind.LeftOuter)
in
  #"Merged queries";
shared #"SalesLT CustomerAddress" = let
  Source = Sql.Database("tinaserver.database.windows.net", "testdb"),
  #"Navigation 1" = Source{[Schema = "SalesLT", Item = "CustomerAddress"]}[Data]
in
  #"Navigation 1";
shared #"SalesLT SalesOrderHeader" = let
  Source = Sql.Database("tinaserver.database.windows.net", "testdb"),
  #"Navigation 1" = Source{[Schema = "SalesLT", Item = "SalesOrderHeader"]}[Data]
in
  #"Navigation 1";
shared #"SalesLT Customer_DataDestination" = let
  Pattern = Sql.Database("tinaserver.database.windows.net", "customersalesdata", [CreateNavigationProperties = false, EnableCrossDatabaseFolding = true]),
  TableNavigation = Pattern{[Item = "SalesCustomer", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
