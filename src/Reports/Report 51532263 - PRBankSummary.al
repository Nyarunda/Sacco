/// <summary>
/// Report PR Bank Summary (ID 50565).
/// </summary>

Report 50565 "PR Bank Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/PR Bank Summary.rdl';

    dataset
    {
        dataitem(BankSummary; "HR Bank Summary")
        {
            RequestFilterFields = "Payroll Period";
            column(ReportForNavId_1; 1)
            {
            }
            column(StaffNo; BankSummary."Staff No.")
            {
            }
            column(StaffName; StaffName)
            {
            }
            column(Amount; BankSummary.Amount)
            {
            }
            column(PayrollPeriod; BankSummary."Payroll Period")
            {
            }
            column(BranchCode; BankSummary."Branch Code")
            {
            }
            column(BranchName; BankSummary."Branch Name")
            {
            }
            column(BankCode; BankSummary."Bank Code")
            {
            }
            column(BankName; BankSummary."Bank Name")
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(CompanyAddress; CompanyInformation."Address 2")
            {
            }
            column(CompanyPicture; CompanyInformation.Picture)
            {
            }
            column(CompanyEMail; CompanyInformation."E-Mail")
            {
            }
            column(CompanyTelephone; CompanyInformation."Phone No.")
            {
            }
            column(Num; SerialNo)
            {
            }
            column(AccountNo; BankSummary."A/C  Number")
            {
            }
            column(SalaryH; SalH)
            {
            }

            trigger OnAfterGetRecord()
            begin
                begin

                    SerialNo += 1;

                    if HREmployees.Get(BankSummary."Staff No.") then StaffName := UpperCase(HREmployees.FullName());

                    if TransferToSalaryHeader = true then begin

                        //Insert Salary Lines
                        SalaryLines.SetCurrentkey(SalaryLines."No.");
                        SalaryLines.Find('+');
                        SalaryLines.Init;
                        SalaryLines."No." += 1;
                        SalaryLines."Salary Header No." := SalaryHeader.No;
                        SalaryLines."Account No." := BankSummary."A/C  Number";
                        SalaryLines.Amount := BankSummary.Amount;
                        SalaryLines.Validate("Account No.");
                        if SalaryLines.Insert(true) then
                            salHeaderCreated := true;
                    end;

                    // BankSummary."Salary Header" := SalaryHeader.No;
                    BankSummary.Modify;

                end;
            end;

            trigger OnPostDataItem()
            begin
                if salHeaderCreated = true then
                    Message('An income Processing card has been created.');
            end;

            trigger OnPreDataItem()
            begin
                if CompanyInformation.Get then CompanyInformation.CalcFields(CompanyInformation.Picture);
                CompanyInformation."Address 2" := CompanyInformation.Address + ' - ' + CompanyInformation."Post Code" + ', ' + CompanyInformation.City;
                CompanyInformation."Phone No." := 'CALL: ' + CompanyInformation."Phone No.";
                CompanyInformation."E-Mail" := 'E-MAIL : ' + CompanyInformation."E-Mail";


                if EmployeeNoFilter <> '' then
                    BankSummary.SetFilter("Staff No.", EmployeeNoFilter);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Transfer To Salary Header"; TransferToSalaryHeader)
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Number"; ChequeNumber)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque Number';
                }
                field("Filter by Employee No."; EmployeeNoFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Filter by Employee No.';
                    TableRelation = Employee."No.";
                }
            }
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
        if GuiAllowed then UserAccount := UserId;
    end;

    trigger OnPreReport()
    begin

        if BankSummary.GetFilter("Payroll Period") = '' then begin

            PayrollPeriods.Reset;
            PayrollPeriods.SetRange(PayrollPeriods.Closed, false);
            if PayrollPeriods.FindFirst then SelectedPeriod := PayrollPeriods."Date Opened";

            BankSummary.SetFilter("Payroll Period", '%1', SelectedPeriod);

        end;

        // if TransferToSalaryHeader = true then begin

        //     SalaryHeader.Init;
        //     SalaryHeader."Account Type" := SalaryHeader."account type"::Customer;
        //     SalaryHeader."payment type" := SalaryHeader."payment type"::Salaries;
        //     SalaryHeader."Payment Mode" := SalaryHeader."Payment Mode"::"Staff Salary";
        //     SalaryHeader."External Doc. No" := ChequeNumber;
        //     SalaryHeader.Remarks := 'Staff Salaries';
        //     SalaryHeader."Posting date" := Today;
        //     SalaryHeader."Created By" := UserAccount;
        //     if SalaryHeader.Insert(true) then
        //         SalH := SalaryHeader.No
        //     else
        //         error('Salary header not created!');

        // end;
    end;

    var
        salHeaderCreated: Boolean;
        CompanyInformation: Record "Company Information";
        HREmployees: Record Employee;
        StaffName: Text;
        SerialNo: Integer;
        PayrollPeriods: Record "Payroll Periods";
        SelectedPeriod: Date;
        TransferToSalaryHeader: Boolean;
        SalaryHeader: Record "Salary Header";
        SalaryLines: Record "Salary Lines";
        UserAccount: Text;
        SalH: Code[20];
        EmployeeNoFilter: Code[20];
        ChequeNumber: Code[6];
}
