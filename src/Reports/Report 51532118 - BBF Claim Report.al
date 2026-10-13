report 50387 "BBF Claim Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/BBF Claim Report.rdlc';

    dataset
    {
        dataitem("BBF Requisation Header"; "BBF Entitlement Header")
        {
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(Picture; CompanyInformation.Picture)
            {
            }
            column(SNO; sno)
            {
            }
            column(No_BBFRequisationHeader; "BBF Requisation Header"."No.")
            {
            }
            column(Date_BBFRequisationHeader; "BBF Requisation Header".Date)
            {
            }
            column(CapturedBy_BBFRequisationHeader; "BBF Requisation Header"."Captured By")
            {
            }
            column(Amount_BBFRequisationHeader; "BBF Requisation Header".Amount)
            {
            }
            column(MemberNo_BBFRequisationHeader; "BBF Requisation Header"."Member No")
            {
            }
            column(AccountName_BBFRequisationHeader; "BBF Requisation Header"."Account Name")
            {
            }
            column(ResponsibilyCenter_BBFRequisationHeader; "BBF Requisation Header"."Responsibility Center")
            {
            }

            column(NoSeries_BBFRequisationHeader; "BBF Requisation Header"."No. Series")
            {
            }
            column(Status_BBFRequisationHeader; "BBF Requisation Header".Status)
            {
            }
            column(Payed_BBFRequisationHeader; "BBF Requisation Header".Payed)
            {
            }
            column(Posted_BBFRequisationHeader; "BBF Requisation Header".Posted)
            {
            }
            column(GlobalDimension1Code_BBFRequisationHeader; "BBF Requisation Header"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_BBFRequisationHeader; "BBF Requisation Header"."Global Dimension 2 Code")
            {
            }
            column(PaymentReleaseDate_BBFRequisationHeader; "BBF Requisation Header"."Payment Release Date")
            {
            }
            dataitem("BBF Requisation Lines"; "BBF Entitlement Lines")
            {
                DataItemLink = "Header No" = FIELD("No.");
                column(EntryNo_BBFRequisationLines; "BBF Requisation Lines"."Entry No.")
                {
                }
                column(Type_BBFRequisationHeader; "BBF Requisation Lines"."Relationship Type")
                {
                }
                column(MemberNo_BBFRequisationLines; "BBF Requisation Lines"."Member No")
                {
                }
                column(Name_BBFRequisationLines; "BBF Requisation Lines".Name)
                {
                }
                column(Relationship_BBFRequisationLines; "BBF Requisation Lines".Relationship)
                {
                }
                column(Beneficiary_BBFRequisationLines; "BBF Requisation Lines".Beneficiary)
                {
                }
                column(DateofBirth_BBFRequisationLines; "BBF Requisation Lines"."Date of Birth")
                {
                }
                column(Address_BBFRequisationLines; "BBF Requisation Lines".Address)
                {
                }
                column(Telephone_BBFRequisationLines; "BBF Requisation Lines".Telephone)
                {
                }
                column(Fax_BBFRequisationLines; "BBF Requisation Lines".Fax)
                {
                }
                column(Email_BBFRequisationLines; "BBF Requisation Lines".Email)
                {
                }
                column(IDNo_BBFRequisationLines; "BBF Requisation Lines"."ID No.")
                {
                }
                column(Allocation_BBFRequisationLines; "BBF Requisation Lines"."%Allocation")
                {
                }
                column(Type_BBFRequisationLines; "BBF Requisation Lines".Type)
                {
                }
                column(Deceased_BBFRequisationLines; "BBF Requisation Lines".Deceased)
                {
                }
                column(BBFEntitlementCode_BBFRequisationLines; "BBF Requisation Lines"."BBF Entitlement Code")
                {
                }
                column(BBFEntitlement_BBFRequisationLines; "BBF Requisation Lines"."BBF Entitlement Claimed")
                {
                }
                column(LineNo_BBFRequisationLines; "BBF Requisation Lines"."Line No.")
                {
                }
                column(AccountNo_BBFRequisationLines; "BBF Requisation Lines"."Account No.")
                {
                }
                column(NextofKin_BBFRequisationLines; "BBF Requisation Lines"."Next of Kin")
                {
                }
                column(Posted_BBFRequisationLines; "BBF Requisation Lines".Posted)
                {
                }
                column(HeaderNo_BBFRequisationLines; "BBF Requisation Lines"."Header No")
                {
                }
                column(LoanNo_BBFRequisationLines; "BBF Requisation Lines"."Loan No.")
                {
                }
                column(TransactionType_BBFRequisationLines; "BBF Requisation Lines"."Transaction Type")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                sno += 1;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(CompanyInformation.Picture);
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
        sno: Integer;
        CompanyInformation: Record "Company Information";
}

