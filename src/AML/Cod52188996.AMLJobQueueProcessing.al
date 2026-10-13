

codeunit 50992 "AML Job Queue Processing"
{
    Access = Public;


    trigger OnRun()
    var
        AMLManagement: Codeunit "AML Management";
    begin
        // Main entry point for Job Queue execution
        //AMLManagement.ProcessPendingTransactions();
        AMLManagement.SimulateTransactionsForSavingsAccounts(0D, 0D);
    end;
}
