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
        
    FUNCTION ObfuscateAuftrag() AS VOID
        LOCAL _oDbAuftrag as DBServer
        LOCAL i as DWORD
        _oDbAuftrag := DBServer{"C:\tmp\data\dauftrag"}

    	_oDbAuftrag:setOrder ("iaufnum")
            
        _oDbAuftrag:GoTop()
        i := 1
        System.Console.WriteLine("Starting obfuscation")
        DO WHILE !_oDbAuftrag:eof
            _oDbAuftrag:FIELDPUT(#AUKUNDE, "TestKunde")
            _oDbAuftrag:FIELDPUT(#AUKUNR, "12345")
            _oDbAuftrag:FIELDPUT(#AUMODNUM, "12345")
            _oDbAuftrag:FIELDPUT(#AUWUNSCHKW, "202140")
            _oDbAuftrag:FIELDPUT(#AULIEFKW, "202140")
            _oDbAuftrag:FIELDPUT(#AUFERTKW, "202140")
            _oDbAuftrag:FIELDPUT(#AUBESTDAT, today())
            _oDbAuftrag:FIELDPUT(#ABDATUM, today())
            _oDbAuftrag:FIELDPUT(#AUKMODNR, "12345")
            _oDbAuftrag:FIELDPUT(#AUPREIS, 10)
            _oDbAuftrag:FIELDPUT(#AUHEIM, "")
            _oDbAuftrag:FIELDPUT(#BEDARFKW, "202140")
            _oDbAuftrag:FIELDPUT(#AUFERTDAT, today())
            _oDbAuftrag:FIELDPUT(#STKLI_DAT, today())
            _oDbAuftrag:FIELDPUT(#AULIEFAD, "")
            _oDbAuftrag:FIELDPUT(#WUNSCH_DAT, today())
            _oDbAuftrag:FIELDPUT(#AUKUBESTNR, "67890")
            _oDbAuftrag:FIELDPUT(#PLATTFORM, "shop")
            _oDbAuftrag:FIELDPUT(#ZDATUM, today())
            _oDbAuftrag:FIELDPUT(#ZBETRAG, 10)
            _oDbAuftrag:FIELDPUT(#BANK, "Paypal")
            _oDbAuftrag:skip(1)
            System.Console.WriteLine("Fixed Entry: " + i:ToString())
            i := i + 1
        ENDDO
        _oDbAuftrag:Close()
        System.Console.WriteLine("Done with obfuscation")

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

		//ObfuscateAuftrag()
		TestAuftrag()

		System.Console.WriteLine("Done")
		System.Console.ReadLine();
                    
    END NAMESPACE
