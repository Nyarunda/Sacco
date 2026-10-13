report 50388 "BBF Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/BBF Report.rdlc';

    dataset
    {
        dataitem(Header; "BBF Entitlement Header")
        {
            column(Bal; Bal)
            {
            }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoPicture; CompInfo.Picture)
            {
            }
            column(No_BBFRequisationHeader; Header."No.")
            {
            }
            column(Date_BBFRequisationHeader; Format(Header.Date))
            {
            }
            column(CapturedBy_BBFRequisationHeader; Header."Captured By")
            {
            }
            column(MemberNo_BBFRequisationHeader; Header."Member No")
            {
            }
            column(AccountName_BBFRequisationHeader; Header."Account Name")
            {
            }

            column(Savings; Header.Amount)
            {
            }
            column(Collector_ID; "Collector ID")
            {

            }
            column(Collector_Mobile_No_; "Collector Mobile No.")
            {

            }
            column(Collector_Name; "Collector Name")
            {

            }
            column(Collector_Relationship; "Collector Relationship")
            {

            }
            dataitem(Lines; "BBF Entitlement Lines")
            {
                DataItemLink = "Header No" = FIELD("No.");
                column(IDNo_Lines; Lines."ID No.")
                {
                }
                column(Type_BBFRequisationHeader; Lines."BBF Entitlement Code")
                {
                }
                column(DateofBirth_Lines; Lines."Date of Birth")
                {
                }
                column(Name_Lines; Lines.Name)
                {
                }
                column(Relationship_Lines; Lines.Relationship)
                {
                }
                column(Relationship_Type; "Relationship Type")
                {
                }
                column(BBFEntitlement_Lines;
                Lines."BBF Entitlement Claimed")
                {
                }
                column(AccountNo_Lines; Lines."Account No.")
                {
                }
                column(NextofKin_Lines; Lines."Next of Kin")
                {
                }
                column(BBF_Entitlement_Code; "BBF Entitlement Code")
                {
                }

            }

            trigger OnAfterGetRecord()
            begin
                Bal := 0;
                Savings.Reset;
                Savings.SetRange("Member No.", Header."Member No");
                Savings.SetRange("Product Category", Savings."Product Category"::"Benevolent Fund");
                if Savings.FindFirst then begin
                    Bal := MemberAct.GetAccountBalance(Savings."No.");
                end;
            end;

            trigger OnPreDataItem()
            begin
                CompInfo.Get;
                CompInfo.CalcFields(Picture);
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
        CompInfo: Record "Company Information";
        MemberAct: codeunit "Member Activities";
        Bal: Decimal;
        Savings: Record "Savings Accounts";
}

