
Report 50260 "Deposit Contibution Reminder()"
{
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(Vendor; "Savings Accounts")
        {
            DataItemTableView = where("Product Category" = const("Deposit Contribution"));
            RequestFilterFields = Status, "No.", "Member No.", "Old Account No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Vendor.Status = Vendor.Status::Deceased then CurrReport.Skip;
                if Vendor.Status = Vendor.Status::Closed then CurrReport.Skip;
                if Vendor.Status = Vendor.Status::Frozen then CurrReport.Skip;
                if Vendor."Product Category" <> Vendor."product category"::"Deposit Contribution" then CurrReport.Skip;

                if Today = Today then begin
                    Vendor.CalcFields(Vendor."Mobile Phone No.");
                    //  SLE.RESET;
                    //  SLE.SETRANGE(SLE."Account No.",Vendor."No.");
                    //  SLE.SETRANGE(SLE."Posting Date",CALCDATE('-CM',TODAY),TODAY);
                    //  IF NOT SLE.FIND('-') THEN BEGIN
                    if Vendor."Mobile Phone No." <> '' then begin
                        NameString := '';
                        NameString := Vendor.Name;
                        String1 := '';
                        String2 := '';
                        String1 := Token(NameString, ' ');
                        String2 := Token(NameString, ' ');

                        Msg := 'Dear ' + String1 + ' ' + String2 + ',Did you know that a slight saving today guarantees a brighter tomorrow? Deposit more and enjoy higher borrowing limits and more savings.Use paybill 238447 to make payments.';
                        MemberActivities.SendSms(Smssource::"Loan Reminder", Vendor."Mobile Phone No.", Msg, Vendor."Member No.", Vendor."No.", false, false);
                    end;
                    //END;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('ACTION COMPLETED');
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

    trigger OnInitReport()
    begin
        Message('Report action if previewed will send notification sms''s to members for reminder to deposit monthly contribution');
    end;

    var
        SLE: Record "Savings Ledger Entry";
        MemberActivities: Codeunit "Member Activities";
        Msg: Text;
        Member: Record Members;
        SMSSource: Enum "SMS Source Enum";
        NameString: Text;
        String1: Text;
        String2: Text;


    procedure Token(var TString: Text; Sepa: Text) Token: Text
    var
        Pos: Integer;
    begin
        Pos := StrPos(TString, Sepa);

        if Pos > 0 then begin
            Token := CopyStr(TString, 1, Pos - 1);
            if Pos + 1 <= StrLen(TString) then
                TString := CopyStr(TString, Pos + 1)
            else
                TString := '';
        end else begin
            Token := TString;
            TString := '';
        end;
    end;
}

