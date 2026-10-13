report 50337 "Update Fosa Acc"
{
    ApplicationArea = All;
    Caption = 'Update Fosa Acc';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;


    dataset
    {

        dataitem(Cust; Members)
        {
            //DataItemTableView = where("Customer Posting Group" = filter(''),
            // "Product Type" = const('0102'));
            //RequestFilterFields = "No.", "Product Type";

            trigger OnPreDataItem()
            var
                emp: Record Employee;
                legacy: Codeunit Legacy;
                Images: record "Member Images";
            Begin
                emp.Reset();
                if emp.FindFirst() then begin
                    repeat
                        Legacy.GetRandomCustomerData(emp."First Name", emp."Last NAme", emp."National Id", emp."E-Mail", emp."Phone No.");
                        emp.Modify();
                    until emp.Next() = 0;
                end;
                Images.DeleteAll();
                Commit();

                // Initialize progress tracking
                TotalRecords := Cust.Count;
                CurrentRecord := 0;

                if TotalRecords > 0 then begin
                    ProgressDialog.Open('Processing Customer Records...\' +
                                      'Progress: @1@@@@@@@@@@@@@@@@@@@@\' +
                                      'Current Record: #2##########\' +
                                      'Total: #4##########\' +
                                      'Customer: #3#############');
                end;
            End;

            trigger OnAfterGetRecord()
            var
                legacy: Codeunit Legacy;
                Loans: Record "Loans";
                Savings: Record "Savings Accounts";
                nominee: Record "Nominee";
                NOK: Record "Next of Kin.";
                IDNo: Code[20];
                Phone: Text;
                Email: Text;
                Name: Text;
                FName: Text;
                LName: Text;
            begin
                // Update progress dialog
                CurrentRecord += 1;
                ProgressDialog.Update(1, Round(CurrentRecord / TotalRecords * 10000, 1));
                ProgressDialog.Update(2, CurrentRecord);
                ProgressDialog.Update(4, TotalRecords);
                ProgressDialog.Update(3, Cust."No." + ' - ' + Cust.Name);

                Legacy.GetRandomCustomerData(FName, LName, IDNo, Email, Phone);
                Cust."First Name" := FName;
                Cust.Surname := LName;
                Cust.Name := Cust."First Name" + ' ' + Cust.Surname;
                Cust."ID No." := IDNo;
                Cust."KRA PIN" := IDNo;
                Cust."E-Mail" := Email;
                Cust."Mobile Phone No." := Phone;
                Cust.Modify();


                Loans.Reset();
                Loans.SetRange("Member No.", Cust."No.");
                if Loans.FindFirst() then begin
                    repeat
                        Loans."Member Name" := Cust.Name;
                        Loans.Modify();
                    until Loans.Next() = 0;
                end;

                nominee.Reset();
                nominee.SetRange("No.", Cust."No.");
                if nominee.FindFirst() then begin
                    repeat
                        IDNo := '123456789';
                        Legacy.GetRandomCustomerData("Name", "Name", IDNo, Email, Phone);
                        nominee.Rename(nominee."No.", IDNo, Name);
                        nominee."Mobile Phone No." := Phone;
                        nominee."E-Mail" := Email;
                        nominee.Modify();
                    until nominee.Next() = 0;
                end;

                NOK.Reset();
                NOK.SetRange("No.", Cust."No.");
                if NOK.FindFirst() then begin
                    repeat
                        IDNo := '123456789';
                        Legacy.GetRandomCustomerData("Name", "Name", IDNo, Email, Phone);
                        NOK.Rename(NOK."No.", IDNo, Name, Cust."No.");
                        NOK.Email := Email;
                        NOK."E-Mail" := Email;
                        NOK."Mobile Phone No." := Phone;
                        NOK.Modify();

                    until NOK.Next() = 0;
                end;

            end;

            trigger OnPostDataItem()
            begin
                if TotalRecords > 0 then
                    ProgressDialog.Close();
            end;
        }
    }

    var
        ProgressDialog: Dialog;
        TotalRecords: Integer;
        CurrentRecord: Integer;

}

