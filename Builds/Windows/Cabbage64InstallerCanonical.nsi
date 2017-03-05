; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Cabbage64"
!define PRODUCT_VERSION ""
!define PRODUCT_PUBLISHER "Cabbage Audio"
!define PRODUCT_WEB_SITE "http://www.cabbageaudio.com"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\Cabbage64.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; MUI 1.67 compatible ------
!include "MUI.nsh"
!include "EnvVarUpdate.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "cabbage.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE "..\..\GNUGeneralPublicLicense.txt"
; Directory page
!insertmacro MUI_PAGE_DIRECTORY

!insertmacro MUI_PAGE_COMPONENTS

; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\Cabbage64.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------


Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "Output\Cabbage64CanonicalSetup.exe"
InstallDir "$PROGRAMFILES64\Cabbage64Canonical"
ShowInstDetails show
ShowUnInstDetails show

Section "Core components" SEC01
  SetOutPath "$INSTDIR"
  ${EnvVarUpdate} $0 "PATH" "P" "HKLM" "$INSTDIR"                            ; Prepend
  ${EnvVarUpdate} $0 "CABBAGE_OPCODE_PATH" "A" "HKLM" "$INSTDIR"                            ; Prepend
  SetOverwrite ifnewer
  File "buildCanon64\Cabbage64.exe"
  #File "buildCanon64\CabbageStudio64.exe"

  CreateDirectory "$SMPROGRAMS64\Cabbage64Canonical"
  
  CreateShortCut "$SMPROGRAMS64\Cabbage64Canonical\Cabbage64.lnk" "$INSTDIR\Cabbage64.exe"
  #CreateShortCut "$SMPROGRAMS64\Cabbage64Canonical\CabbageStudio64.lnk" "$INSTDIR\CabbageStudio64.exe"
  CreateShortCut "$DESKTOP\Cabbage64.lnk" "$INSTDIR\Cabbage64.exe"

  File "buildCanon64\CabbagePluginEffect.dat"
  File "buildCanon64\CabbagePluginSynth.dat"
  File "C:\Users\rory\sourcecode\cabbageaudio\fmod_csoundL64.dll"
  File "build\opcodes.txt"
  File "build\IntroScreen.csd"
  File "build\cabbageEarphones.png"
  File "build\cabbage.png"
  
  ;libsndfile
  ; File "C:\Program Files (x86)\Mega-Nerd\libsndfile\bin\libsndfile-1.dll"
  ; ;liblo
  ; File "C:\Users\rory\sourcecode\liblo-0.28\src\.libs\liblo-7.dll"
  ; ;mingw files
  ; File "C:\mingw64\bin\libwinpthread-1.dll"
  ; ;File "C:\mingw64\bin\libgcc_s_dw2-1.dll"
  ;File "C:\mingw64\bin\libstdc++-6.dll"
  ;docs and examples
  SetOutPath "$INSTDIR\Docs\_book\"
  File /r "..\..\Docs\_book\*"
  SetOutPath "$INSTDIR\Examples\"
  File /r "..\..\Examples\*"
  SetOutPath "$INSTDIR\csoundDocs\"
  File /r  "..\..\..\csoundDocs\*"

SectionEnd

; Section descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC01} "Installs Cabbage64, Csound should already be installed."
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\Cabbage64\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\Cabbage64\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\Cabbage64.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\Cabbage64.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  ${un.EnvVarUpdate} $0 "PATH" "R" "HKLM" "$INSTDIR"
  ${un.EnvVarUpdate} $0 "CABBAGE_OPCODE_PATH" "R" "HKLM" "$INSTDIR"
  
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"

  Delete "$SMPROGRAMS64\Cabbage64\Uninstall.lnk"
  Delete "$SMPROGRAMS64\Cabbage64\Website.lnk"
  Delete "$INSTDIR\IntroScreen.csd"
  Delete "$INSTDIR\cabbage.png"
  Delete "$INSTDIR\cabbageEarphones.png"
  Delete "$DESKTOP\Cabbage64.lnk"
  Delete "$SMPROGRAMS\Cabbage64\Cabbage64.lnk"
  Delete "$INSTDIR\commandLineTest.csd"
  Delete "$INSTDIR\Cabbage64.exe"
  Delete "$INSTDIR\CabbagePluginEffect.dat"
  Delete "$INSTDIR\CabbagePluginSynth.dat"
  #Delete "$INSTDIR\CabbageStudio64.exe"
  Delete "$INSTDIR\opcodes.txt"




  SetOutPath $SMPROGRAMS
  RMDir /r "$INSTDIR\csoundDocs"
  RMDir /r "$INSTDIR\Examples"
  RMDir /r "$INSTDIR\Docs"
  RMDir "$SMPROGRAMS\Cabbage64"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd
