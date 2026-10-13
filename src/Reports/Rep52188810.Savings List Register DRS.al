Report 50492 "Savings List Register DRS"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Savings List Register DRS.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Recruited by Type", "Recruited By", "Registration Date", "Member Status";
            column(Recruited_by_Type; "Recruited by Type")
            {
            }
            column(Recruited_By_Name; "Recruited By Name")
            {
            }
            dataitem(SavingsAccounts; "Savings Accounts")
            {
                DataItemLink = "Member No." = field("No.");
                DataItemTableView = sorting("Member No.");
                RequestFilterFields = "No.", "Product Type", "Product Category", "Member No.";
                column(ReportForNavId_1; 1)
                {
                }
                column(ShowFuuzaTxt; ShowFuuzaTxt)
                {
                }
                column(FuuzaLimit; FuuzaLimit)
                {
                }
                column(CompanyInformation_Name; CompanyInformation.Name)
                {
                }
                column(CompanyInformation_Picture; CompanyInformation.Picture)
                {
                }
                column(CompanyAddress; CompanyAddress)
                {
                }
                column(CompanyTelephone; CompanyTelephone)
                {
                }
                column(CommunicationOnline; CommunicationOnline)
                {
                }
                column(No_SavingsAccounts; SavingsAccounts."No.")
                {
                }
                column(Name_SavingsAccounts; SavingsAccounts.Name)
                {
                }
                column(GlobalDimension1Code_SavingsAccounts; SavingsAccounts."Global Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_SavingsAccounts; SavingsAccounts."Global Dimension 2 Code")
                {
                }
                column(EmployerCode_SavingsAccounts; '')
                {
                }
                column(ProductType_SavingsAccounts; SavingsAccounts."Product Name")
                {
                }
                column(ProductName_SavingsAccounts; SavingsAccounts."Product Name")
                {
                }
                column(MemberNo_SavingsAccounts; SavingsAccounts."Member No.")
                {
                }
                column(PayrollStaffNo_SavingsAccounts; SavingsAccounts."Payroll/Staff No.")
                {
                }
                column(PhoneNo_SavingsAccounts; SavingsAccounts."Mobile Phone No.")
                {
                }
                column(RecruitedBy_SavingsAccounts; '')
                {
                }
                column(RecruitedByName_SavingsAccounts; '')
                {
                }
                column(IDNumber_SavingsAccounts; SavingsAccounts."ID No.")
                {
                }
                column(BirthCertificateNo_SavingsAccounts; '')
                {
                }
                column(SalespersonCode_SavingsAccounts; '')
                {
                }
                column(CreatedBy_SavingsAccounts; '')
                {
                }
                column(Source_SavingsAccounts; '')
                {
                }
                column(Status_SavingsAccounts; SavingsAccounts.Status)
                {
                }
                column(BalanceLCY_SavingsAccounts; SavingsAccounts."Net Change (LCY)")
                {
                }
                column(SCount; SNo)
                {
                }
                column(MaturityDate; '')
                {
                }
                column(OldMemberNo_SavingsAccounts; '')
                {
                }
                column(CustomerCID_SavingsAccounts; '')
                {
                }
                column(OldAccountNo_SavingsAccounts; SavingsAccounts."Old Account No.")
                {
                }

                trigger OnAfterGetRecord()
                var
                    PSetup: Record "Product Setup";
                    SAccount: Record "SACCO Account";
                    VLEdger: Record "Savings Ledger Entry";
                    VL: Record "Savings Ledger Entry";
                    VAccount: Record "Savings Accounts";
                    NewNo: Code[20];
                    Members: Record Members;
                    Ussd: Record "USSD Auth";
                begin
                    //SavingsAccounts.SETCURRENTKEY(SavingsAccounts."Member No.");
                    CalcFields("Membership Date");

                    ShowFuuzaTxt := '';
                    FuuzaLimit := 0;
                    if ShowFuuza then begin

                        ShowFuuzaTxt := 'Yes';
                        FuuzaLimit := Sky.GetFuuzaLimit("No.", today);
                    end;
                    /*
                    if PSetup.get("Product Type") then begin
                        if (CopyStr("No.", 1, 4) = '0102') then begin
                            CalcFields(Duplicates);
                            if Duplicates = 2 then begin

                                FosaSavings.Reset();
                                FosaSavings.SetRange("Member No.", "Member No.");
                                FosaSavings.SetRange("Product Type", "Product Type");
                                FosaSavings.SetFilter("No.", '<>%1', "No.");
                                FosaSavings.SetFilter("Transactional Mobile No", '');
                                if FosaSavings.FindFirst() then begin
                                    if (CopyStr(FosaSavings."No.", 1, 4) <> '0102') Then begin

                                        VLEdger.Reset();
                                        VLEdger.SetRange("Account No.", FosaSavings."No.");
                                        if VLEdger.FindFirst() then begin
                                            repeat
                                                VLEdger."Account No." := "No.";
                                                VLEdger.modify;
                                            until VLEdger.next = 0;
                                        end;

                                        VL.Reset();
                                        VL.SetRange("Account No.", FosaSavings."No.");
                                        if VL.FindFirst() then begin
                                            repeat
                                                VL."Account No." := "No.";
                                                VL.modify;
                                            until VL.next = 0;
                                        end;


                                        VLEdger.Reset();
                                        VLEdger.SetRange("Account No.", FosaSavings."No.");
                                        if not VLEdger.FindFirst() then begin
                                            FosaSavings.Delete();
                                        end;

                                    end;
                                end;

                            end;
                        end;
                    end;
                    */

                    

                    if Cust.Get("Member No.") then begin

                        if BranchCode <> '' then
                            if Cust."Global Dimension 2 Code" <> BranchCode then
                                CurrReport.Skip;

                    end;
                    SNo += 1;
                end;

                trigger OnPredataitem()
                var
                    GL: Record "G/L Entry";
                begin

                end;

            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

                if BranchCode <> '' then
                    if Members."Global Dimension 2 Code" <> BranchCode then
                        CurrReport.Skip;

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(BranchCode; BranchCode)
                {
                    ApplicationArea = Basic;
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
                }
                field(ShowFuuza; ShowFuuza)
                {
                    ApplicationArea = Basic;
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

    trigger OnPreReport()
    begin

        MActivities.CheckViewReportsPermmission(UserId);

        if CompanyInformation.Get then
            //CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
#pragma warning disable AL0432
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
#pragma warning restore AL0432

    end;

    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        UserSetup.Get(UserId);
        if not UserSetup.Reports then
            Error('You do not have any permissions to access this report. Contact the administrator!');
    end;

    var
        UserSetup: Record "User Setup";
        FosaSavings: Record "Savings Accounts";
        RepayMode: Enum "Repay Mode Enum";
        MemberActivities: Codeunit "Member Activities";
        BranchCode: Code[10];
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SNo: Integer;
        MAccount: Record "Savings Accounts";
        FosaBal: Decimal;
        Cust: Record Members;
        ShowFuuzaTxt: Text;
        ShowFuuza: Boolean;
        FuuzaLimit: Decimal;
        Sky: Codeunit "Sky MBanking";
        MActivities: Codeunit "Member Activities";


}


