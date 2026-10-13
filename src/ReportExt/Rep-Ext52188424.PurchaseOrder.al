namespace UnitedWomen.UnitedWomen;

using Microsoft.Purchases.Document;

reportextension 50013 "Purchase Order" extends "Order"
{
    wordLayout = './src/Layouts/PurchaseOrder.docx';

    dataset
    {

        add("Purchase Header")
        {
            column(Preparedby; UserId)
            {
            }
            column(ApprovedBy; ApprovedBy)
            {
            }
            column(CertifiedBy; CertifiedBy)
            {
            }


        }
        add("Purchase Line")
        {

        }
    }

    var
        PreparedBy: Text;
        ApprovedBy: Text;
        CertifiedBy: Text;
}
