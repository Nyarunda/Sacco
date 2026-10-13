
Report 50257 "Deposit Contibution Reminder"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Vendor; "Savings Accounts")
        {
            DataItemTableView = where("Product Category" = const("Deposit Contribution"));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Vendor.Status = Vendor.Status::Deceased then CurrReport.Skip;
                if Vendor.Status = Vendor.Status::Closed then CurrReport.Skip;
                if Vendor.Status = Vendor.Status::Frozen then CurrReport.Skip;
                if Vendor."Product Category" <> Vendor."product category"::"Deposit Contribution" then CurrReport.Skip;

                if Today = CalcDate('CM-1D', Today) then begin
                    Vendor.CalcFields(Vendor."Mobile Phone No.");
                    SLE.Reset;
                    SLE.SetRange(SLE."Account No.", Vendor."No.");
                    SLE.SetRange(SLE."Posting Date", CalcDate('-CM', Today), Today);
                    if not SLE.Find('-') then begin
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
                    end;
                end;
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
        //MESSAGE('%1',CALCDATE('CM-1D',TODAY));
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

