report 50587 "Dividends Progression"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/Dividends Progression.rdlc';

    dataset
    {
        dataitem("Members Register"; Members)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; CompanyInformation.Name)
            {
            }
            column(Company_Pic; CompanyInformation.Picture)
            {
            }
            // CurrReport.PAGENO removed due to deprecation warning
            column(EMail_MembersRegister; "Members Register"."E-Mail")
            {
            }
            column(PhoneNo_MembersRegister; "Members Register"."Phone No.")
            {
            }
            column(USERID; USERID)
            {
            }
            column(MobilePhoneNo_MembersRegister; "Members Register"."Mobile Phone No.")
            {
            }
            column(Members__No__; "No.")
            {
            }
            column(Members__Payroll_Staff_No_; "Payroll/Staff No.")
            {
            }
            column(IDNo_MembersRegister; "Members Register"."ID No.")
            {
            }
            column(Members_Name; Name)
            {
            }
            column(Pin_MembersRegister; "Members Register"."KRA Pin")
            {
            }
            column(Dividends_ProgressionCaption; Dividends_ProgressionCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Members__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Members__Payroll_Staff_No_Caption; FIELDCAPTION("Payroll/Staff No."))
            {
            }
            column(Members_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(Dividends_Progression_SharesCaption; "Dividends Progression".FIELDCAPTION(Shares))
            {
            }
            column(Dividends_Progression__Qualifying_Shares_Caption; "Dividends Progression".FIELDCAPTION("Qualifying Shares"))
            {
            }
            column(Dividends_Progression__Net_Dividends_Caption; "Dividends Progression".FIELDCAPTION("Net Dividends"))
            {
            }
            column(Dividends_Progression__Witholding_Tax_Caption; "Dividends Progression".FIELDCAPTION("Witholding Tax"))
            {
            }
            column(Dividends_Progression__Gross_Dividends_Caption; "Dividends Progression".FIELDCAPTION("Gross Dividends"))
            {
            }
            column(Dividends_Progression_DateCaption; "Dividends Progression".FIELDCAPTION("End Date"))
            {
            }
            dataitem("Dividends Progression"; "Dividends Progression")
            {

                DataItemLinkReference = "Members Register";
                DataItemLink = "Member No" = FIELD("No.");

                column(StartDate_DividendsProgression; "Dividends Progression"."Start Date")
                {
                }
                column(End_Dividends_Progression_Date; "End Date")
                {
                }
                column(NetChange_DividendsProgression; "Dividends Progression".Shares)
                {
                }
                column(QualifyingAmount_DividendsProgression; "Dividends Progression"."Qualifying Shares")
                {
                }
                column(Iterator_DividendsProgression; 12)
                {
                }
                column(The_Rate; The_Rate)
                {
                }
                column(GrossAmount_DividendsProgression; "Dividends Progression"."Gross Dividends")
                {
                }
                column(WitholdingTax_DividendsProgression; "Dividends Progression"."Witholding Tax")
                {
                }
                column(NetAmount_DividendsProgression; "Dividends Progression"."Net Dividends")
                {
                }
                column(Period_DividendsProgression; "Dividends Progression"."Dividend Year")
                {
                }
                column(Product_DividendsProgression; "Dividends Progression"."Product Name")
                {
                }

                dataitem(PSetUp; "Product Setup")
                {
                    column(Dividend_Percentage; PSetUp."Interest Rate (Max.)")
                    {
                    }

                    column(Withholding_Tax; PSetUp."WithHolding Tax")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                var
                    ProdSetUp: Record "Product Setup";
                begin
                    ProdSetUp.GET("Dividends Progression"."Product Type");
                    The_Rate := ProdSetUp."Interest Rate (Max.)" * 0.01;
                end;
            }

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(Picture);
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
        Dividends_ProgressionCaptionLbl: Label 'Dividends Progression';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CompanyInformation: Record "Company Information";
        The_Rate: Decimal;

}

