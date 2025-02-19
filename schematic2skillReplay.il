;ineed('schematic2skillReplay t)

cvs=dbOpenCellViewByType( "PICMIC1_ebecheto" "TOP_TEST" "schematic" "schematic" "r") ;now routing is manual, do not
cv=cvs

filename=buildString(list(cv~>libName cv~>cellName cv~>viewName ".il") "_")
fname=strcat(pwd() "/"  filename)

version="0.1"
fp = outfile(fname "w")
fprintf(fp ";load(%L) ;;/!\\loop if uncomment\n" fname)
fprintf(fp ";;ineed('schematic2skillReplay) ;;version %s\n" version)
fprintf(fp "ineed('(geOpenOrRaisecv))\n")
;; list(inst~>libName inst~>cellName inst~>viewName inst~>master~>cellViewType)
;; inst~>??
;; instm=css()
;; iins
;; instm~>prop~>??
;close(fp)
;edit(eval(fname))

;; HEADER
txt=sprintf(nil "cv=dbOpenCellViewByType(%L %L %L %L %L)\n" cv~>libName strcat(cv~>cellName "_play") cv~>viewName cv~>cellViewType "w")
fprintf(fp txt) drain(fp)

;; CREATE
;; inst~>baseName;=> "I0"
;; set(stringToSymbol(inst~>baseName) 3)
;; I0;=> 3
;'(inst~>baseName)=dbOpenCellViewByType( "tsl18fs120" "mx04d0" "layout" "maskLayout" "r")
; list(inst~>libName inst~>cellName inst~>viewName inst~>master~>cellViewType)
inst=car( cv~>instances)
foreach(inst setof(i cv~>instances i~>purpose!="pin") ; setof(i cv~>instances i~>purpose=="cell")
txt=sprintf(nil "%s=dbOpenCellViewByType%L\n" inst~>baseName list(inst~>libName inst~>cellName inst~>viewName inst~>master~>cellViewType))
fprintf(fp txt) drain(fp)
;( cv swy  sw~>baseName xup+1.6+dxsw*i:yup "R0")
txt=sprintf(nil "dbCreateInst(cv %s %L '%L %L)\n" inst~>baseName inst~>baseName inst~>xy inst~>orient)
fprintf(fp txt) drain(fp)


;; studdy 
prop=car(inst~>prop)
foreach(mapcar prop inst~>prop ;list(prop~>name prop~>value prop~>valueType) 
;=> (("newPcellStyle" "Yes") ("fps" "2.02") ("fpd" "2.02") ("fas" "0.2138") ("fad" "0.2138") ("ps" "2.02") ("pd" "2.02") ("as" "0.2138") ("ad" "0.2138") ("nf" "1") ("wf" "0.22") ("w" "0.22") ("sDContToG" "0.16"))
;; FOREACH PROP
;dbReplaceProp(inst "cutColumns" 'int cutColumns)
txt=sprintf(nil "dbReplaceProp(%s %L '%s %L)\n" inst~>baseName prop~>name prop~>valueType prop~>value)
fprintf(fp txt) drain(fp)
); end props
);end instances


;; PIN A TRAITER A PART
;; cv~>terminals
;; term=car(cv~>terminals)
foreach(mapcar term cv~>terminals
term~>name;=> "cra<0:7>"
term~>direction;=> "input"
term~>??
;=> (db:0x4f34351a cellView db:0x4f34249a objType "term" prop nil direction "input" groupMembers nil name "cra<0:7>" net db:0x4f343644 numBits 8 pins (db:0x4f343b9a) routeMethod nil connRoutes nil textDisplays (db:0x4f343b32) assocTextDisplays (db:0x4f343b32) pinCount 1 markers nil mustJoinTerms nil position nil physOnly nil pinConnectMethod nil isInterface t)
;; pin~>master~>??;=> nil
;; pin~>fig~>master~>libName;=> "basic"
;; pin~>fig~>master~>cellName;=> "ipin"
;; pin~>fig~>master~>viewName;=> "symbol"
;; pin=car(term~>pins);=> db:0x4f343b9a
foreach(mapcar pin term~>pins
pin~>name;=> "P__0"
pin~>fig~>orient;=> "R0"
pin~>fig~>xy;=> (-4.5625 -0.53125)
;;aPin = dbOpenCellViewByType("basic" cadr(lap)  "symbol")
txt=sprintf(nil "%s=dbOpenCellViewByType(%L %L %L)\n" pin~>name pin~>fig~>master~>libName pin~>fig~>master~>cellName pin~>fig~>master~>viewName)
fprintf(fp txt) drain(fp)
;;pinId=schCreatePin( cv aPin sprintf(nil "%s_%d" pinName iout) pin~>direction nil XY "R0")
txt=sprintf(nil "schCreatePin(cv %s %L %L nil '%L %L)\n" pin~>name term~>name term~>direction pin~>fig~>xy pin~>fig~>orient)
fprintf(fp txt) drain(fp)
); end pins
);end term

;; GENERATE SHORT NETS ?
;; OR GENERATE A COPY OF THE NETS ?
ineed('getInstTermPoint)
getInstTermPoint(inst)
;=> (("qin6<7:0>" (2.34375 -4.46875)) ("qin5<7:0>" (2.21875 -4.46875)) ("qin4<7:0>" (2.09375 -4.46875)) ("qin3<7:0>" (1.96875 -4.46875)) ("qin2<7:0>" (1.84375 -4.46875)) ("qin1<7:0>" (1.71875 -4.46875)) ("qin0<7:0>" (1.59375 -4.46875)) ("XPD" (0.78125 -3.84375)) ("VFE_CSA" (0.78125 -4.09375)) ("IREF_ext_PAD" (0.78125 -3.71875)) ("IREF_b2" (0.78125 -3.46875)) ("IREF_b1" (0.78125 -3.34375)) ("IREF_b0" (0.78125 -3.21875)) ("ENA_IREF_ext" (0.78125 -3.59375)) ("CMP_REF" (0.78125 -4.34375)) ("ADJG<7:0>" (2.46875 -4.46875)) ("VCS2" (3.21875 -3.34375)) ("IREF2" (3.21875 -3.21875)) ("dac<0>,dac<2:6>" (3.21875 -3.46875)) ("iin_TST" (2.53125 -3.09375)) ("Comp_TST" (2.71875 -4.46875)) ("ENA_TST" (2.59375 -4.46875)) ("SF_TST" (2.84375 -4.46875)))

conn=car(inst~>conns)
conn~>??
conn~>net~>??
;=> (db:0x7624822e cellView db:0x2c8f901a objType "net" prop nil allInstTerms (db:0x557b9a3a) connStatus nil criticality 0 figs (db:0x4f3455ce db:0x4f3455ae) routePattern "steiner" groupMembers nil instTerms (db:0x557b9a3a) name "SF_TST" numBits 1 parent nil pins (db:0x4f34553e) shieldNet1 nil shieldNet2 nil signals (db:0x7624822e) sigNames ("SF_TST") subnet nil subnets nil term db:0x2c8f8247 terms (db:0x2c8f8247) textDisplays nil assocTextDisplays nil instTermCount 1 markers nil routes nil source "netlist" sigType "signal" aliases ("SF_TST") isGlobal nil memInstTerms ((db:0x557b9a3a 0)) memNets ((db:0x7624822e 0)) memTerms ((db:0x2c8f8247 0)))
;=> (db:0x557b9a3a cellView db:0x2c8f901a objType "instTerm" prop nil direction "output" groupMembers nil inst db:0x557b969a name "SF_TST" net db:0x7624822e numBits 1 term db:0x4c262676 widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic")
inst~>conns~>??
;=> ((db:0x557b9a3a cellView db:0x2c8f901a objType "instTerm" prop nil direction "output" groupMembers nil inst db:0x557b969a name "SF_TST" net db:0x7624822e numBits 1 term db:0x4c262676 widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b9a39 cellView db:0x2c8f901a objType "instTerm" prop nil direction "input" groupMembers nil inst db:0x557b969a name "ENA_TST" net db:0x7624822b numBits 1 term db:0x4c262675 widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b9a38 cellView db:0x2c8f901a objType "instTerm" prop nil direction "output" groupMembers nil inst db:0x557b969a name "Comp_TST" net db:0x7624822d numBits 1 term db:0x4c262674 widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b9a35 cellView db:0x2c8f901a objType "instTerm" prop nil direction "input" groupMembers nil inst db:0x557b969a name "iin_TST" net db:0x76220ca1 numBits 1 term db:0x4c262673 widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b99e1 cellView db:0x2c8f901a objType "instTerm" prop nil direction "output" groupMembers nil inst db:0x557b969a name "dac<0>,dac<2:6>" net db:0x7624811b numBits 6 term db:0x4c262672 widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b99f0 cellView db:0x2c8f901a objType "instTerm" prop nil direction "output" groupMembers nil inst db:0x557b969a name "IREF2" net db:0x762481b7 numBits 1 term db:0x4c262669 widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b99ef cellView db:0x2c8f901a objType "instTerm" prop nil direction "output" groupMembers nil inst db:0x557b969a name "VCS2" net db:0x762481b6 numBits 1 term db:0x4c262668 widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b99e5 cellView db:0x2c8f901a objType "instTerm" prop nil direction "input" groupMembers nil inst db:0x557b969a name "ADJG<7:0>" net db:0x7624815f numBits 8 term db:0x4c262666 widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b99e0 cellView db:0x2c8f901a objType "instTerm" prop nil direction "input" groupMembers nil inst db:0x557b969a name "CMP_REF" net db:0x762481cd numBits 1 term db:0x4c262661 widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b99df cellView db:0x2c8f901a objType "instTerm" prop nil direction "input" groupMembers nil inst db:0x557b969a name "ENA_IREF_ext" net db:0x7624815b numBits 1 term db:0x4c262660 widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b99de cellView db:0x2c8f901a objType "instTerm" prop nil direction "input" groupMembers nil inst db:0x557b969a name "IREF_b0" net db:0x7624815a numBits 1 term db:0x4c26265e widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b99dd cellView db:0x2c8f901a objType "instTerm" prop nil direction "input" groupMembers nil inst db:0x557b969a name "IREF_b1" net db:0x7624815c numBits 1 term db:0x4c26265d widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b99dc cellView db:0x2c8f901a objType "instTerm" prop nil direction "input" groupMembers nil inst db:0x557b969a name "IREF_b2" net db:0x7624815d numBits 1 term db:0x4c26265c widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b99db cellView db:0x2c8f901a objType "instTerm" prop nil direction "input" groupMembers nil inst db:0x557b969a name "IREF_ext_PAD" net db:0x7624815e numBits 1 term db:0x4c26265b widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b99da cellView db:0x2c8f901a objType "instTerm" prop nil direction "input" groupMembers nil inst db:0x557b969a name "VFE_CSA" net db:0x7624817b numBits 1 term db:0x4c26265a widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b99d9 cellView db:0x2c8f901a objType "instTerm" prop nil direction "input" groupMembers nil inst db:0x557b969a name "XPD" net db:0x76248169 numBits 1 term db:0x4c262659 widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b99d0 cellView db:0x2c8f901a objType "instTerm" prop nil direction "input" groupMembers nil inst db:0x557b969a name "qin0<7:0>" net db:0x76248150 numBits 8 term db:0x4c262650 widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b99c7 cellView db:0x2c8f901a objType "instTerm" prop nil direction "input" groupMembers nil inst db:0x557b969a name "qin1<7:0>" net db:0x76248147 numBits 8 term db:0x4c262647 widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b99be cellView db:0x2c8f901a objType "instTerm" prop nil direction "input" groupMembers nil inst db:0x557b969a name "qin2<7:0>" net db:0x7624813e numBits 8 term db:0x4c26263e widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b99b5 cellView db:0x2c8f901a objType "instTerm" prop nil direction "input" groupMembers nil inst db:0x557b969a name "qin3<7:0>" net db:0x76248135 numBits 8 term db:0x4c262635 widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b99ac cellView db:0x2c8f901a objType "instTerm" prop nil direction "input" groupMembers nil inst db:0x557b969a name "qin4<7:0>" net db:0x7624812c numBits 8 term db:0x4c26262c widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b99a3 cellView db:0x2c8f901a objType "instTerm" prop nil direction "input" groupMembers nil inst db:0x557b969a name "qin5<7:0>" net db:0x76248123 numBits 8 term db:0x4c262623 widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic") (db:0x557b999a cellView db:0x2c8f901a objType "instTerm" prop nil direction "input" groupMembers nil inst db:0x557b969a name "qin6<7:0>" net db:0x7624811a numBits 8 term db:0x4c26261a widthOK t connRoutes nil textDisplays nil assocTextDisplays nil markers nil termPosition nil routeMethod "symbolic"))

;; FOOTER

fprintf(fp txt) drain(fp)
fprintf(fp "geOpenOrRaisecv(cv)\n")

close(fp)
