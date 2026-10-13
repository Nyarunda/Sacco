report 50562 "Dividend Slip Portal 2"
{
    Caption = 'Dividend Slip Portal 2';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Dividend Slip.rdlc';

    dataset
    {
        dataitem(DividendProgression; "Dividends Progression")
        {
            RequestFilterFields = "Member No", "Start Date", "End Date";
            column(ReportForNavId_1; 1)
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
            column(StartDate_DividendProgression; CalcDate('CM', DividendProgression."End Date"))
            {
            }
            column(ProductType_DividendProgression; DividendProgression."Product Type")
            {
            }
            column(ProductName_DividendProgression; DividendProgression."Product Name")
            {
            }
            column(QualifyingShares_DividendProgression; DividendProgression."Qualifying Shares")
            {
            }
            column(Shares_DividendProgression; DividendProgression.Shares)
            {
            }
            column(GrossDividends_DividendProgression; DividendProgression."Gross Dividends")
            {
            }
            column(WitholdingTax_DividendProgression; DividendProgression."Witholding Tax")
            {
            }
            column(NetDividends_DividendProgression; DividendProgression."Net Dividends")
            {
            }
            column(No_Members; DividendProgression."Member No")
            {
            }
            column(ElectrolZone; ElectrolZone)
            {
            }
            column(Maddress; Maddress)
            {
            }
            column(Mcity; Mcity)
            {
            }
            column(Mname; MName)
            {
            }
            column(MPayrollNo; MPayrollNo)
            {
            }
            column(MNo; MNo)
            {
            }
            column(DivRate; DivRate)
            {
            }
            column(IntRate; IntRate)
            {
            }
            column(WthTax; WthTax)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Members.Reset;
                Members.SetRange("No.", DividendProgression."Member No");
                if Members.Find('-') then begin
                    //ElectrolZone := Members."Electrol Zone";
                    //Department:=
                    Maddress := Members."Post Code";
                    Mcity := Members.City;
                    MName := Members.Name;
                    MNo := Members."No.";
                    MPayrollNo := Members."Payroll/Staff No.";
                end;

                if ProductFactory.Get(DividendProgression."Product Type") then begin
                    if ProductFactory."Interest Rate (Max.)" <> 0 then
                        DivRate := ProductFactory."Interest Rate (Max.)";
                    if ProductFactory."Interest Rate (Max.)" <> 0 then
                        IntRate := ProductFactory."Interest Rate (Min.)";
                    if ProductFactory."WithHolding Tax" <> 0 then
                        WthTax := ProductFactory."WithHolding Tax";
                end;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if MemberNo <> '' then
                    SetRange("Member No", MemberNo);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Filters")
                {
                    field("Member No."; MemberNo)
                    {
                        ApplicationArea = Basic;
                        TableRelation = Members;
                        LookupPageId = "Member Listing";

                    }
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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
#pragma warning disable AL0432
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
#pragma warning restore AL0432
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        MNo: Code[50];
        MName: Text;
        MPayrollNo: Code[10];
        MIDNumber: Code[10];
        MEmployer: Code[10];
        Members: Record Members;
        ElectrolZone: Text;
        Department: Code[20];
        Section: Code[20];
        Maddress: Text[20];
        Mcity: Text[20];
        ProductFactory: Record "Product Setup";
        DivRate: Decimal;
        IntRate: Decimal;
        WthTax: Decimal;
        MemberNo: Code[20];


    procedure SetMemberNo(pMemberNo: Code[20])
    begin
        MemberNo := pMemberNo;
    end;

}

