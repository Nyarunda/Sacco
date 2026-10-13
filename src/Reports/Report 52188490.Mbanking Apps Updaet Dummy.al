
Report 50153 "Mbanking Apps Updaet Dummy"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Mbanking Apps Updaet Dummy.rdlc';

    dataset
    {
        dataitem(Accounts; Vendor)
        {
            DataItemTableView = where("Product Category" = const("Ordinary Savings"));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            var
                SkyMbanking: Codeunit "Sky Mbanking";
            begin

                MemberAccounts.Reset;
                MemberAccounts.SetRange("Transactional Mobile No", Accounts."Transactional Mobile No");
                if MemberAccounts.FindFirst then
                    if MemberAccounts.Count = 1 then begin


                        Auth.Reset;
                        Auth.SetRange("Account No.", Accounts."No.");
                        Auth.SetRange("Mobile No.", Accounts."Transactional Mobile No");
                        if not Auth.FindFirst then begin
                            Auth.Init;
                            Auth."Mobile No." := Accounts."Transactional Mobile No";
                            Auth."Account No." := Accounts."No.";
                            Auth."User Status" := Auth."user status"::Active;
                            Auth.Insert;
                            SkyMbanking.GenerateNewPin(CopyStr(Accounts."Transactional Mobile No", 2, 12));
                        end;
                    end;


                /*
                MBankingApplications.RESET;
                MBankingApplications.SETRANGE("Account No",Accounts."No.");
                IF NOT MBankingApplications.FINDFIRST THEN BEGIN
                    NOs:=INCSTR(NOs);
                    MBankingApplications.INIT;
                    MBankingApplications.No := NOs;
                    MBankingApplications."Application Type" := MBankingApplications."Application Type"::Change;
                    MBankingApplications.VALIDATE("Account No",Accounts."No.");
                    MBankingApplications."MPESA Mobile No" := Accounts."Transactional Mobile No";
                    MBankingApplications."Application Type" := MBankingApplications."Application Type"::Initial;
                    MBankingApplications.Status := MBankingApplications.Status::Approved;
                    MBankingApplications."App Status" := MBankingApplications."App Status"::Approved;
                    MBankingApplications.INSERT(TRUE);
                
                END;
                */

            end;

            trigger OnPreDataItem()
            begin


                Accounts.SetFilter("Transactional Mobile No", '<>%1', '');
                //NOs := 'MBA0000035';
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
        MemberAccounts: Record "Savings Accounts";
        Dummy: Record "Dummy Upload Mpesa Nos";
        MBankingApplications: Record "MBanking Applications";
        NOs: Code[20];
        Auth: Record "Sky USSD Auth";
}

