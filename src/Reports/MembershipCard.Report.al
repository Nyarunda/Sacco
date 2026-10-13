Report 50189 "Membership Card"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Membership Card.rdlc';

    dataset
    {
        dataitem(Members; Members)
        {
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(FOSAAccount_Members; Members."No.")
            {
            }
            column(IDNo_Members; Members."ID No.")
            {
            }
            column(PFNumber_Members; Members."Payroll/Staff No.")
            {
            }
            column(RegistrationDate_Members; Members."Registration Date")
            {
            }
            column(Image_Picture; MImage.Picture)
            {
            }
            column(Image_Signature; MImage.Signature)
            {
            }
            column(CompanyInfo_Picture; Company.Picture)
            {
            }
            column(companyInfo_Name; Company.Name)
            {
            }

            trigger OnAfterGetRecord()
            begin

                MImage.SetRange("Member No.", "No.");
                if MImage.Findfirst then
                    MImage.CalcFields(Picture, Signature);

                if (MImage.Picture.Hasvalue) and (MImage.Signature.Hasvalue) then begin
                    //if not "Member Card Printed" then begin
                    //  "Member Card Printed" := true;
                    // Modify;
                    //end
                    //else
                    //  Message('This Member Card has been printed before');

                end;
            end;

            trigger OnPreDataItem()
            begin
                Company.Get();
                Company.CalcFields(Company.Picture);
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
        Company: Record "Company Information";
        MImage: Record "Member Images";
}

