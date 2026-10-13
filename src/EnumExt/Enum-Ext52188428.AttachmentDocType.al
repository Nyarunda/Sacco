namespace UnitedWomen.UnitedWomen;

using Microsoft.Foundation.Attachment;

enumextension 50063 "Attachment Doc. Type" extends "Attachment Document Type"
{
    value(50000; Loan) { Caption = 'Loan'; }
    value(50001; Savings) { Caption = 'Savings'; }
    value(50002; Member) { Caption = 'Member'; }
    value(50003; Collateral) { Caption = 'Collateral'; }
    value(50004; "Member Exit") { Caption = 'Member Exit'; }

}
