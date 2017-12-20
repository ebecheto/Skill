procedure(EFcreateContact(contactType Xcut Ycut)
leSetEnv("contactResetRowCol" nil)
leSetEnv("contactName" contactType)
; I think your Xcut and Ycut were back to front?
leSetEnv("contactRows" Ycut)
leSetEnv("contactColumns" Xcut)
leHiCreateContact()
)

; And then you can call EFcreateContact("v12" 4 3) 
; tfcDeleteRuleContactDevice(
; tfcDeleteSymContactDevice(
; symContactDevice(
