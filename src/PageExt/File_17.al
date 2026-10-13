
PageExtension 50120 pageextension50120 extends "FA Depreciation Books"
{
    layout
    {
        addafter("Straight-Line %")
        {
            field("Customized Depr. Amount"; Rec."Customized Depr. Amount")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

