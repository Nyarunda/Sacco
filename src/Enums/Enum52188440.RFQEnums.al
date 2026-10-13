namespace UnitedWomen.UnitedWomen;



enum 50084 "RFQ Criteria Type"
{
    Extensible = true;
    value(0; Compliance) { Caption = 'Statutory Compliance'; }
    value(1; Pricing) { Caption = 'Price Comparison'; }
    value(2; Quality) { Caption = 'Quality'; }
    value(3; Delivery) { Caption = 'Delivery Timeliness'; }
    value(4; Technical) { Caption = 'Technical Capability'; }
    value(5; TrackRecord) { Caption = 'Vendor Track Record'; }
}
enum 50085 "RFQ Document Type"
{
    Extensible = true;
    value(0; RFQ) { Caption = 'Goods (RFQ)'; }
    value(1; RFP) { Caption = 'Services (RFP)'; }
}


