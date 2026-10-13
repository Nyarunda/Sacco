xmlport 50007 Test
{
    Caption = 'Test';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(SasraSectorialLevel2; "Sasra Sectorial Level 2")
            {
                fieldattribute(MainSector; SasraSectorialLevel2."Main Sector")
                {
                }
                fieldattribute(SubSectorLevel1Code; SasraSectorialLevel2."Sub-Sector Level 1 Code")
                {
                }
                fieldattribute(SubSectorLevel2Code; SasraSectorialLevel2."Sub-Sector Level 2 Code")
                {
                }
                fieldattribute(SubSectorLevel2Description; SasraSectorialLevel2."Sub-Sector Level 2 Description")
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
