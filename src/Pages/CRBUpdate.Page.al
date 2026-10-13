Page 50216 "CRB Update"
{
    Editable = false;
    PageType = List;
    SourceTable = "CRB Main Data";
    SourceTableView = where("Client Type" = const(Loanee));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = Basic;
                }
                field("Other Names"; Rec."Name 2" + ' ' + Rec."Name 3" + ' ' + Rec."Name 4")
                {
                    ApplicationArea = Basic;
                }
                field(PrimaryIdentification1; Rec."Primary Identification 1")
                {
                    ApplicationArea = Basic;
                }
                field(SecondaryIdentification1; Rec."Secondary Identification 1")
                {
                    ApplicationArea = Basic;
                }
                field("Service No."; "Service No.")
                {
                    ApplicationArea = Basic;
                }
                field("Alien No."; "Alien No.")
                {
                    ApplicationArea = Basic;
                }
                field(PINNo; Rec."PIN No.")
                {
                    ApplicationArea = Basic;
                }
                field(DateofBirth; Rec."Update Date of Birth")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                }
                field(CurrencyofFacilty; Rec."Currency of Facilty")
                {
                    ApplicationArea = Basic;
                }
                field(OriginalAmount; Rec."Update Original Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Original Amount';
                }
                field(AmountPaid; Rec."Update Amount Paid")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Paid';
                }
                field(CurrentBalance; Rec."Update Current Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Balance';
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(DateofLastPayment; Rec."Update Date of Last Payment")
                {
                    ApplicationArea = Basic;
                    Caption = ' Date of Last Payment';
                }
                field(AccountStatus; Rec."Account Status")
                {
                    ApplicationArea = Basic;
                }
                field(NoofDaysinArrears; Rec."No. of Days in Arrears")
                {
                    ApplicationArea = Basic;
                }
                field(NoofInstallmentsinArrears; Rec."No. of Installments in Arrears")
                {
                    ApplicationArea = Basic;
                }
                field(OverdueBalance; Rec."Update Overdue Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Overdue Balance';
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(ScheduledPayment; Rec."Update Scheduled Payment")
                {
                    ApplicationArea = Basic;
                    Caption = ' Scheduled Payment';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        //OtherNames:=
    end;

    var
        "Service No.": Text;
        "Alien No.": Text;
        OtherNames: Text;
}

