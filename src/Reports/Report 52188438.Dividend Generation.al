
Report 50082 "Dividend Generation"
{
    ProcessingOnly = true;


    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = where("Type" = filter(Group | Member));
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                RecordCounter += 1;
                dWindow.Update(1, Members.Name);
                dWindow.Update(3, RecordCounter);
                dWindow.Update(4, ROUND(RecordCounter / TotalRecords * 10000, 1));

                SaccoActivities.GenerateDivdends(Members."No.", StartDate, EndDate, Members."Physically Challenged");
            end;

            trigger OnPostDataItem()
            begin
                dWindow.Close;
            end;

            trigger OnPreDataItem()
            Var
                Usersetup: Record "User Setup";
            begin

                UserSetup.Get(UserId);
                if not UserSetup."Dividend Processing" then
                    Error('You do not have any permissions for dividend processing to access. Contact the administrator!');


                dWindow.Open('Dividend Generation:            #1#########\'
                                    + 'Total Members:              #2#########\'
                                    + 'Counter:                    #3#########\'
                                    + 'Progress:                  @4@@@@@@@@@\'
                                    + 'Press Esc to abort');



                TotalRecords := Members.Count;
                dWindow.Update(2, TotalRecords);
                RecordCounter := 0;


                SaccoSetup.Get;

                SaccoSetup.TestField("Dividend Year Date");

                StartDate := CalcDate('-1Y+CY', SaccoSetup."Dividend Year Date");
                EndDate := CalcDate('CY', SaccoSetup."Dividend Year Date");

            end;
        }


    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        TotalRecords: Integer;
        dWindow: Dialog;
        FAcc: Record "Savings Accounts";
        SaccoActivities: Codeunit "Sacco Activities";
        RecordCounter: Integer;
        StartDate: Date;
        EndDate: Date;
        SaccoSetup: Record "Sacco Setup";
        SNo: Code[20];
        ENo: Code[20];
}

