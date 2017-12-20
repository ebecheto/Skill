; source ~/bin/spb.env.sh
; source ~/bin/spb.sh;
; cd $CDSROOT/tools/bin
; ./cdsmps -i -nongraph $CDSROOT/tools/fet/skill-01.00/context/cnInit.il
; ./cnskill -i -nongraph
; ./cnskill -i 

loadi("~/Skill/menu.il")
ineed('shout)
load("emacs_ipcPipe.il")

load("/home/validmgr/ebecheto/test.il")
shout("which allegro")
;=> "/data/cadence/SPB166/tools/pcb/bin/allegro\n"
; $CDSROOT/tools/fet/skill-01.00/samples/Eventecho/evecho.il
; /data/cadence/SPB166/tools/fet/skill-01.00/samples/Eventecho/evecho.il
; http://community.cadence.com/cadence_technology_forums/f/28/t/16610
allegro_handle=ipcBeginProcess("allegro");<= dans linux c'est pas .exe
; ipcKillProcess(allegro_handle)

schema_handle=ipcBeginProcess("concept")

help('cnSendCommand)

procedure( addComp()
 cnSendCommand(allegro_handle, "add resistor.sym_1")
 cnSendCommand(allegro_handle, "add capasitor.sym_1")
)