USING System
using bTools.bServer
using XSharp.RDD


BEGIN NAMESPACE TestAppXSharp
        
    FUNCTION TestAuftrag() AS VOID
        LOCAL _oDbAuftrag as DBServer
        _oDbAuftrag := DBServer{"C:\tmp\data\dauftrag"}

    	_oDbAuftrag:setOrder ("iaufnum")
        
        //_oDbAuftrag:Zap()
        
        IF _oDbAuftrag:Append()
            _oDbAuftrag:FIELDPUT(#AUNUMMER, "123")
            _oDbAuftrag:Skip(0)
        ELSE 
            System.Console.WriteLine("Damn")
        ENDIF
            
        _oDbAuftrag:GoBottom()
        _oDbAuftrag:skip(-2)
        DO WHILE !_oDbAuftrag:eof
            System.Console.WriteLine("AuNummer: " + (string)_oDbAuftrag:FIELDGET(#AUNUMMER))
            _oDbAuftrag:skip(1)
        ENDDO
        _oDbAuftrag:Close()

    FUNCTION Start() AS VOID STRICT

	SetCollation(#CLIPPER)
	SetAnsi(false)
	SetInternational (#CLIPPER)
	SetDecimalSep  (Asc(","))
	SetThousandSep (Asc("."))
	SetDateCountry(GERMAN)
	SetEpoch(1990)
	SetCentury(true)
	SetExclusive(FALSE)
	SetDeleted(true)
	Enable3dControls ()

	RDDSETDEFAULT("DBFCDX")
	//RDDSETDEFAULT("AXDBFCDX")

	TestAuftrag()

	System.Console.WriteLine("Done")
	System.Console.ReadLine();
                    
    END NAMESPACE
