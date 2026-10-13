
Report 50254 "Monthly Maintenance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Monthly Maintenance.rdlc';
    UsageCategory = Tasks;

    dataset
    {
        dataitem(PSetup; "Product Setup")
        {
            DataItemTableView = where("Monthly Maintenance Fee" = filter(> 0));
            column(ReportForNavId_1; 1)
            {
            }
            dataitem(Accounts; "Savings Accounts")
            {
                DataItemLink = "Product Type" = field("Product ID");
                column(ReportForNavId_2; 2)
                {
                }

                trigger OnAfterGetRecord()
                Var
                    TChannel: Enum "Transaction Channel";
                begin
                    Memb.Reset;
                    Memb.SetRange(Memb."No.", Accounts."Member No.");
                    if Memb.Find('-') then begin
                        if Memb."Registration Date" >= CalcDate('-6M', Today) then
                            CurrReport.Skip;
                    end;

                    AccBal := MemberActivities.GetAccountBalance(Accounts."No.");
                    if AccBal >= TransAmt + Duty then begin
                        //FOR NON RECOVERED
                        //TO BE COMMENTED AFTER ITS USED
                        /*SLedger.RESET;
                        SLedger.SETRANGE("Account No.",Accounts."No.");
                        SLedger.SETRANGE("Document No.",DocNo);
                        IF NOT SLedger.FINDFIRST THEN BEGIN
                          IF AccBal >= (TransAmt+Duty)*2 THEN BEGIN
                            SaccoActivities.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,Accounts."No.",Desc,
                                BalAcctType::"G/L Account",BalGl,TransAmt*2,ExtDocNo,'',TransType::" ",Accounts."Global Dimension 1 Code",Accounts."Global Dimension 2 Code",TRUE);

                            SaccoActivities.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,Accounts."No.",'Excise Duty',
                                BalAcctType::"G/L Account",SaccoSetup."Excise Duty GL",Duty*2,ExtDocNo,'',TransType::" ",Accounts."Global Dimension 1 Code",Accounts."Global Dimension 2 Code",TRUE);
                          END ELSE BEGIN
                             SaccoActivities.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,Accounts."No.",Desc,
                                BalAcctType::"G/L Account",BalGl,TransAmt,ExtDocNo,'',TransType::" ",Accounts."Global Dimension 1 Code",Accounts."Global Dimension 2 Code",TRUE);

                            SaccoActivities.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,Accounts."No.",'Excise Duty',
                                BalAcctType::"G/L Account",SaccoSetup."Excise Duty GL",Duty,ExtDocNo,'',TransType::" ",Accounts."Global Dimension 1 Code",Accounts."Global Dimension 2 Code",TRUE);
                          END;
                        END;*/
                        //TO BE COMMENTED AFTER ITS USED

                        //FOR RECOVERED
                        SLedger.Reset;
                        SLedger.SetRange("Account No.", Accounts."No.");
                        //SLedger.SETRANGE("Document No.",DocNo);
                        //IF NOT SLedger.FINDFIRST THEN BEGIN
                        if SLedger.FindFirst then begin
                            SaccoActivities.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, Accounts."No.", Desc,
                                Balaccttype::"G/L Account", BalGl, TransAmt, ExtDocNo, '', Transtype::" ", Accounts."Global Dimension 1 Code", Accounts."Global Dimension 2 Code", true,
                                TChannel::" ", Accounts."Dimension Set ID");

                            SaccoActivities.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, Accounts."No.", 'Excise Duty',
                                Balaccttype::"G/L Account", SaccoSetup."Excise Duty GL", Duty, ExtDocNo, '', Transtype::" ", Accounts."Global Dimension 1 Code", Accounts."Global Dimension 2 Code", true,
                                TChannel::" ", Accounts."Dimension Set ID");
                        end;
                    end;

                end;
            }

            trigger OnAfterGetRecord()
            begin

                TransAmt := PSetup."Monthly Maintenance Fee";
                BalGl := PSetup."Maintenance Fee [G/L]";
                Duty := ROUND(TransAmt * SaccoSetup."Excise Duty (%)" / 100);
            end;

            trigger OnPostDataItem()
            begin
                Message('Completed: \%1\%2', JTemplate, JBatch);
            end;

            trigger OnPreDataItem()
            begin

                JTemplate := '';
                JBatch := '';

                if PDate = 0D then
                    PDate := Today;

                SaccoActivities.GetGeneralJournalTemplate(JTemplate, JBatch);

                SaccoActivities.JournalInit(JTemplate, JBatch);
                SaccoSetup.Get;


                DocNo := 'MAINTENANCE';

                if Date2dmy(PDate, 2) = 1 then
                    MonthYear := 'January ' + Format(Date2dmy(PDate, 3))
                else
                    if Date2dmy(PDate, 2) = 2 then
                        MonthYear := 'February ' + Format(Date2dmy(PDate, 3))
                    else
                        if Date2dmy(PDate, 2) = 3 then
                            MonthYear := 'March ' + Format(Date2dmy(PDate, 3))
                        else
                            if Date2dmy(PDate, 2) = 4 then
                                MonthYear := 'April ' + Format(Date2dmy(PDate, 3))
                            else
                                if Date2dmy(PDate, 2) = 5 then
                                    MonthYear := 'May ' + Format(Date2dmy(PDate, 3))
                                else
                                    if Date2dmy(PDate, 2) = 6 then
                                        MonthYear := 'June ' + Format(Date2dmy(PDate, 3))
                                    else
                                        if Date2dmy(PDate, 2) = 7 then
                                            MonthYear := 'July ' + Format(Date2dmy(PDate, 3))
                                        else
                                            if Date2dmy(PDate, 2) = 8 then
                                                MonthYear := 'August ' + Format(Date2dmy(PDate, 3))
                                            else
                                                if Date2dmy(PDate, 2) = 9 then
                                                    MonthYear := 'September ' + Format(Date2dmy(PDate, 3))
                                                else
                                                    if Date2dmy(PDate, 2) = 10 then
                                                        MonthYear := 'October ' + Format(Date2dmy(PDate, 3))
                                                    else
                                                        if Date2dmy(PDate, 2) = 11 then
                                                            MonthYear := 'November ' + Format(Date2dmy(PDate, 3))
                                                        else
                                                            if Date2dmy(PDate, 2) = 12 then
                                                                MonthYear := 'December ' + Format(Date2dmy(PDate, 3));

                Desc := 'Maintenance Fee :: ' + MonthYear;

                /*
                
                IF PDate <= DMY2DATE(30,6,DATE2DMY(TODAY,3)) THEN BEGIN
                    SDate := DMY2DATE(1,1,DATE2DMY(TODAY,3));
                    EDate := DMY2DATE(30,6,DATE2DMY(TODAY,3));
                END
                ELSE BEGIN
                    SDate := DMY2DATE(1,7,DATE2DMY(TODAY,3));
                    EDate := DMY2DATE(31,12,DATE2DMY(TODAY,3));
                END;
                
                
                IF EDate < DMY2DATE(30,6,DATE2DMY(TODAY,3)) THEN
                    Desc := Desc+' PERIOD 2';
                
                */

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Posting Date"; PDate)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Desc)
                {
                    ApplicationArea = Basic;
                    Visible = false;
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

    var
        SaccoActivities: Codeunit "Sacco Activities";
        JTemplate: Code[10];
        JBatch: Code[10];
        MemberActivities: Codeunit "Member Activities";
        AccBal: Decimal;
        Duty: Decimal;
        TransAmt: Decimal;
        DocNo: Code[20];
        PDate: Date;
        Desc: Text;
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        BalGl: Code[10];
        ExtDocNo: Code[10];
        SaccoSetup: Record "Sacco Setup";
        SDate: Date;
        EDate: Date;
        SLedger: Record "Savings Ledger Entry";
        Memb: Record Members;
        MonthYear: Text;
}

