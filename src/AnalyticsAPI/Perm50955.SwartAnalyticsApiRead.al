namespace UnitedWomen.UnitedWomen;

permissionset 51255 "SWART ANALYTICS API"
{
    Assignable = true;
    Caption = 'Swart Analytics API Read';
    Permissions =
        tabledata Members = R,
        tabledata Loans = R,
        tabledata "Savings Accounts" = R,
        tabledata "Savings Ledger Entry" = R,
        tabledata "Credit Ledger Entry" = R,
        page "Swart Members API" = X,
        page "Swart Loans API" = X,
        page "Swart Savings Accounts API" = X,
        page "Swart Savings Ledger API" = X,
        page "Swart Credit Ledger API" = X;
}
