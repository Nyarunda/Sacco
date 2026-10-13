
/// <summary>
/// Report Checkoff Advice Report New (ID 50385).
/// </summary>
Report 50385 "Checkoff Advice Report New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Checkoff Advice Report New.rdlc';

    dataset
    {
        dataitem("Monthly Advice"; "Monthly Advice Header")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_2; 2)
            {
            }
            column(CompanyName; Company.Name)
            {
            }
            column(CompanyPicture; Company.Picture)
            {
            }
            column(EmployerCode_CheckoffAdviceHeader; "Employer Code")
            {
            }
            column(EmployerName_CheckoffAdviceHeader; "Monthly Advice"."Employer Code")
            {
            }
            column(EndDate_CheckoffAdviceHeader; "Monthly Advice"."End Date")
            {
            }
            column(Period_CheckoffAdviceHeader; "Monthly Advice"."End Date")
            {
            }
            dataitem(Members; Members)
            {
                DataItemLink = "Employer Code" = field("Employer Code");
                column(ReportForNavId_1; 1)
                {
                }
                column(No_Members; "No.")
                {
                }
                column(Name_Members; Name)
                {
                }
                column(PayrollStaffNo_Members; "Payroll/Staff No.")
                {
                }
                dataitem("Product Setup"; "Product Setup")
                {

#pragma warning disable AL0254
                    DataItemTableView = sorting("Advice Sorting Order") where("Advice Sorting Order" = filter(> 0));
#pragma warning restore AL0254
                    column(ReportForNavId_3; 3)
                    {
                    }
                    column(ProductID_ProductFactory; Description)
                    {
                    }
                    column(ProductDescription_ProductFactory; Description)
                    {
                    }
                    dataitem(Account; "Product Setup")
                    {
                        DataItemLink = "Product ID" = field("Product ID");
                        column(ReportForNavId_4; 4)
                        {
                        }
                        column(AccCont; AccCont)
                        {
                        }
                        column(AccBalance; AccBalance)
                        {
                        }
                        column(TCont; TCont)
                        {
                        }
                        column(Arrears; Arrears)
                        {

                        }

                        trigger OnAfterGetRecord()
                        begin

                            AccCont := 0;
                            if Account."Product Class" = Account."product class"::Savings then begin
                                SavingsAccounts.Reset;
                                SavingsAccounts.SetRange("Member No.", MemberNo);
                                SavingsAccounts.SetRange("Employer Code", EmpCode);
                                SavingsAccounts.SetRange("Product Type", Account."Product ID");
                                if SavingsAccounts.FindFirst then begin
                                    repeat

                                        SavingsAccounts.CalcFields("Balance (LCY)");

                                        AccBalance := SavingsAccounts."Balance (LCY)";

                                        ChAdvice.Reset;
                                        ChAdvice.SetRange("Advice Header No.", HeaderNo);
                                        ChAdvice.SetRange("Member No.", MemberNo);
                                        ChAdvice.SetRange("Product Type", Account."Product ID");
                                        if ChAdvice.Find('-') then begin
                                            ChAdvice.CalcSums(Amount);
                                            AccCont := ChAdvice.Amount;
                                        end;

                                    until SavingsAccounts.Next = 0;
                                end;
                            end;



                            if (Account."Product Class" = Account."product class"::Credit) then begin
                                Loans.Reset;
                                Loans.SetRange("Member No.", MemberNo);
                                Loans.SetRange("Employer Code", EmpCode);
                                Loans.SetRange("Loan Product Type", Account."Product ID");
                                if Loans.FindFirst then begin
                                    AccCont := 0;
                                    repeat

                                        Loans.CalcFields("Outstanding Principal");

                                        AccBalance := Loans."Outstanding Principal";

                                        ChAdvice.Reset;
                                        ChAdvice.SetRange("Advice Header No.", HeaderNo);
                                        ChAdvice.SetRange("Member No.", MemberNo);
                                        ChAdvice.SetRange("Product Type", Account."Product ID");
                                        if ChAdvice.Find('-') then begin
                                            ChAdvice.CalcSums(Amount, "Principal Arrears");
                                            AccCont := ChAdvice.Amount;
                                            Arrears := ChAdvice."Principal Arrears";
                                        end;

                                    until Loans.Next = 0;
                                end;
                            end;


                            TCont += AccCont;
                            //MESSAGE('AccCont %1\%2',AccCont,"Savings Accounts"."Product Type");

                            //  MESSAGE('TCOnt %1\MEmber %2',TCont,MemberNo);
                        end;
                    }
                    trigger OnAfterGetRecord()
                    var
                        myInt: Integer;
                    begin
                        if "Product Class" = "Product Class"::Savings then begin
                            if ("Minimum Contribution" = 0) and ("Mandatory Contribution" = 0) then begin
                                CurrReport.Skip();
                            end;
                        end;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    MemberNo := "No.";
                    TCont := 0;

                    ChAdvice.Reset;
                    //ChAdvice.SetRange("Employer Code", EmpCode);
                    //ChAdvice.SetRange("Advice Date", AdvDate);
                    ChAdvice.SetRange("Advice Header No.", HeaderNo);
                    ChAdvice.SetRange("Member No.", "No.");
                    if not ChAdvice.Find('-') then begin
                        CurrReport.Skip;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                AdvDate := "Monthly Advice"."End Date";
                HeaderNo := "Monthly Advice"."No.";
                EmpCode := "Monthly Advice"."Employer Code";
            end;

            trigger OnPreDataItem()
            begin
                Company.Get;
                Company.CalcFields(Picture);
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
        ProductFactory: Record "Product Setup";
        Loans: Record Loans;
        Cust: Record Members;
        ClolumHeader: Code[10];
        ColumnValue: Decimal;
        MemberNo: Code[10];
        PayrollNo: Code[10];
        Name: Text;
        Interest: Decimal;
        Amount: Decimal;
        Turn: Integer;
        CulumnA: array[50] of Code[10];
        Company: Record "Company Information";
        i: Integer;
        EDcode: Code[10];
        SaccoCode: Code[10];
        NarationCode: Text;
        IntCode: Integer;
        ActionCode: Code[10];
        TransCode: Integer;
        ChAdvice: Record "Monthly Advice";
        AccCont: Decimal;
        AccBalance: Decimal;
        HeaderNo: Code[20];
        TCont: Decimal;
        SavingsAccounts: Record "Savings Accounts";
        SDate: Date;
        EDate: Date;
        AdvDate: Date;
        EmpCode: Code[20];
        Arrears: Decimal;
}

