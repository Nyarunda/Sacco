report 50380 "Advice Report Summary"
{
    ApplicationArea = All;
    Caption = 'Advice Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Advice Report Summary.rdl';
    dataset
    {
        dataitem(MonthlyAdviceHeader; "Monthly Advice Header")
        {
            column(No; "No.")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(EmployerName; "Employer Name")
            {
            }
            column(EndDate; "End Date")
            {
            }

            dataitem(Customer; Members)
            {
                //DataItemLink = "Employer Code" = field("Employer Code");
                DataItemLinkReference = MonthlyAdviceHeader;
                DataItemLink = "Employer Code" = FIELD("Employer Code");
                column(Mobile_Phone_No_; "Mobile Phone No.")
                {
                }
                column(No_; "No.")
                {
                }
                column(Employer_Code; "Employer Code")
                {
                }
                column(Employer_Name; "Employer Name")
                {
                }
                column(Name; Name)
                {
                }
                column(Payroll_Staff_No_; "Payroll/Staff No.")
                {
                }
                dataitem("Product Setup"; "Product Setup")
                {

                    //   DataItemTableView = SORTING("Product ID") ORDER(Descending);
                    column(Product_ID; "Product ID")
                    {
                    }

                    column(Description; Description)
                    {
                    }
                    column(AccBalance; AccBalance)
                    {
                    }
                    column(AccCont; AccCont)
                    {
                    }
                    column(TCont; TCont)
                    {
                    }
                    column(TCheckoff; TCheckoff)
                    {
                    }
                    trigger OnPreDataItem()
                    begin
                        HeaderNo := MonthlyAdviceHeader."No.";
                    end;

                    trigger OnAfterGetRecord()
                    begin
                        MemberNo := Customer."No.";
                        tcont := 0;
                        AccBalance := 0;
                        AccCont := 0;
                        TCheckoff := 0;

                        ChkAdv.Reset();
                        ChkAdv.SetRange("Advice Header No.", HeaderNo);
                        ChkAdv.SetRange("Member No.", MemberNo);
                        if not ChkAdv.Find('-') then begin
                            CurrReport.skip;
                        end;

                        ChkAdv.Reset();
                        ChkAdv.SetRange("Advice Header No.", HeaderNo);
                        ChkAdv.SetRange("Member No.", MemberNo);
                        ChkAdv.SetRange("Product Type", "Product ID");
                        if ChkAdv.Find('-') then begin
                            ChkAdv.CalcSums("Amount On");
                            AccCont := ChkAdv."Amount On";
                        end;

                        TCont += AccCont;
                        TCheckoff += AccCont;
                    end;

                }

                trigger OnPreDataItem()
                begin
                    HeaderNo := MonthlyAdviceHeader."No.";
                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    ChkAdv.Reset();
                    ChkAdv.SetRange("Advice Header No.", HeaderNo);
                    ChkAdv.SetRange("Member No.", Customer."No.");
                    if not ChkAdv.Find('-') then begin
                        CurrReport.skip;
                    end;
                end;

            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }

        }

        actions
        {
            area(processing)
            {
            }
        }

    }
    var
        AccCont: Decimal;
        AccBalance: Decimal;
        TCont: Decimal;
        TCheckoff: Decimal;
        HeaderNo: Code[20];
        MemberNo: Code[10];
        ChkAdv: record "Monthly Advice";

}

