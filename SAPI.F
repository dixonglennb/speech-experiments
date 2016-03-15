\ Speech API for Windows 2000 and up
\ Tom Dixon 12-8-2002
\ Note: for my personal sanity, not all interfaces and structures have been implemented here

exists com not [if] requires comobj [then]

1 import: CoTaskMemAlloc
1 import: CoTaskMemFree

\ Wave format header
class WAVEFORMATEX
  hsingle wFormatTag
  hsingle nChannels
  single nSamplesPerSec
  single nAvgBytesPerSec
  hsingle nBlockAlign
  hsingle wBitsPerSample
  hsingle cbSize
end-class

\ Wave File Header
class WaveFileHeader
  variable RIFF
  single filesize
  variable wave
  variable format
  single length
end-class

create-guid CLSID_SpNotifyTranslator {E2AE5372-5D40-11D2-960E-00C04F8EE628}
create-guid CLSID_SpObjectTokenCategory {A910187F-0C7A-45AC-92CC-59EDAFB77B53}
create-guid CLSID_SpObjectToken {EF411752-3736-4CB4-9C8C-8EF4CCB58EFE}
create-guid CLSID_SpResourceManager {96749373-3391-11D2-9EE3-00C04F797396}
create-guid CLSID_SpStreamFormatConverter {7013943A-E2EC-11D2-A086-00C04F8EF9B5}
create-guid CLSID_SpMMAudioEnum {AB1890A0-E91F-11D2-BB91-00C04F8EE6C0}
create-guid CLSID_SpMMAudioIn {CF3D2E50-53F2-11D2-960C-00C04F8EE628}
create-guid CLSID_SpMMAudioOut {A8C680EB-3D32-11D2-9EE7-00C04F797396}
create-guid CLSID_SpRecPlayAudio {FEE225FC-7AFD-45E9-95D0-5A318079D911}
create-guid CLSID_SpStream {715D9C59-4442-11D2-9605-00C04F8EE628}
create-guid CLSID_SpVoice  {96749377-3391-11D2-9EE3-00C04F797396}
                          
create-guid CLSID_SpSharedRecoContext {3BEE4890-4FE9-4A37-8C1E-5E7E12791C1F}
create-guid CLSID_SpInprocRecognizer {41B89B6B-9399-11D2-9623-00C04F8EE628}
create-guid CLSID_SpSharedRecognizer {3BEE4890-4FE9-4A37-8C1E-5E7E12791C1F}
create-guid CLSID_SpLexicon {0655E396-25D0-11D3-9C26-00C04F8EF87C}
create-guid CLSID_SpUnCompressedLexicon {C9E37C15-DF92-4727-85D6-72E5EEB6995A}
create-guid CLSID_SpCompressedLexicon {90903716-2F42-11D3-9C26-00C04F8EF87C}
create-guid CLSID_SpPhoneConverter {9185F743-1143-4C28-86B5-BFF14F20E5C8}
create-guid CLSID_SpNullPhoneConverter {455F24E9-7396-4A16-9715-7C0FDBE3EFE3}
create-guid CLSID_SpTextSelectionInformation {0F92030A-CBFD-4AB8-A164-FF5985547FF6}
create-guid CLSID_SpPhraseInfoBuilder {C23FC28D-C55F-4720-8B32-91F73C2BD5D1}
create-guid CLSID_SpAudioFormat {9EF96870-E160-4792-820D-48CF0649E4EC}
create-guid CLSID_SpWaveFormatEx {C79A574C-63BE-44b9-801F-283F87F898BE}
create-guid CLSID_SpInProcRecoContext {73AD6842-ACE0-45E8-A4DD-8795881A2C2A}
create-guid CLSID_SpCustomStream {8DBEF13F-1948-4aa8-8CF0-048EEBED95D8}
create-guid CLSID_SpFileStream {947812B3-2AE1-4644-BA86-9E90DED7EC91}
create-guid CLSID_SpMemoryStream {5FB7EF7D-DFF4-468a-B6B7-2FCBD188F994}

-1 enum SPSF_Default
enum SPSF_NoAssignedFormat
enum SPSF_Text
enum SPSF_NonStandardFormat
enum SPSF_ExtendedAudioFormat
enum SPSF_8kHz8BitMono
enum SPSF_8kHz8BitStereo
enum SPSF_8kHz16BitMono
enum SPSF_8kHz16BitStereo
enum SPSF_11kHz8BitMono
enum SPSF_11kHz8BitStereo
enum SPSF_11kHz16BitMono
enum SPSF_11kHz16BitStereo
enum SPSF_12kHz8BitMono
enum SPSF_12kHz8BitStereo
enum SPSF_12kHz16BitMono
enum SPSF_12kHz16BitStereo
enum SPSF_16kHz8BitMono
enum SPSF_16kHz8BitStereo
enum SPSF_16kHz16BitMono
enum SPSF_16kHz16BitStereo
enum SPSF_22kHz8BitMono
enum SPSF_22kHz8BitStereo
enum SPSF_22kHz16BitMono
enum SPSF_22kHz16BitStereo
enum SPSF_24kHz8BitMono
enum SPSF_24kHz8BitStereo
enum SPSF_24kHz16BitMono
enum SPSF_24kHz16BitStereo
enum SPSF_32kHz8BitMono
enum SPSF_32kHz8BitStereo
enum SPSF_32kHz16BitMono
enum SPSF_32kHz16BitStereo
enum SPSF_44kHz8BitMono
enum SPSF_44kHz8BitStereo
enum SPSF_44kHz16BitMono
enum SPSF_44kHz16BitStereo
enum SPSF_48kHz8BitMono
enum SPSF_48kHz8BitStereo
enum SPSF_48kHz16BitMono
enum SPSF_48kHz16BitStereo
enum SPSF_TrueSpeech_8kHz1BitMono
enum SPSF_CCITT_ALaw_8kHzMono
enum SPSF_CCITT_ALaw_8kHzStereo
enum SPSF_CCITT_ALaw_11kHzMono
enum SPSF_CCITT_ALaw_11kHzStereo
enum SPSF_CCITT_ALaw_22kHzMono
enum SPSF_CCITT_ALaw_22kHzStereo
enum SPSF_CCITT_ALaw_44kHzMono
enum SPSF_CCITT_ALaw_44kHzStereo
enum SPSF_CCITT_uLaw_8kHzMono
enum SPSF_CCITT_uLaw_8kHzStereo
enum SPSF_CCITT_uLaw_11kHzMono
enum SPSF_CCITT_uLaw_11kHzStereo
enum SPSF_CCITT_uLaw_22kHzMono
enum SPSF_CCITT_uLaw_22kHzStereo
enum SPSF_CCITT_uLaw_44kHzMono
enum SPSF_CCITT_uLaw_44kHzStereo
enum SPSF_ADPCM_8kHzMono
enum SPSF_ADPCM_8kHzStereo
enum SPSF_ADPCM_11kHzMono
enum SPSF_ADPCM_11kHzStereo
enum SPSF_ADPCM_22kHzMono
enum SPSF_ADPCM_22kHzStereo
enum SPSF_ADPCM_44kHzMono
enum SPSF_ADPCM_44kHzStereo
enum SPSF_GSM610_8kHzMono
enum SPSF_GSM610_11kHzMono
enum SPSF_GSM610_22kHzMono
enum SPSF_GSM610_44kHzMono
enum SPSF_NUM_FORMATS drop

create-guid IID_ISpNotifySource {5EFF4AEF-8487-11D2-961C-00C04F8EE628}
com subclass ISpNotifySource
2 3 interface SetNotifySink
5 4 interface SetNotifyWindowMessage
4 5 interface SetNotifyCallbackFunction
4 6 interface SetNotifyCallbackInterface
1 7 interface SetNotifyWin32Event
2 8 interface WaitForNotifyEvent
1 9 interface GetNotifyEventHandle
end-class

create-guid IID_ISpNotifySink {259684DC-37C3-11D2-9603-00C04F8EE628}
com subclass ISpNotifySink
1 3 interface Notify
end-class

create-guid IID_ISpNotifyTranslator {ACA16614-5D3D-11D2-960E-00C04F8EE628}
com subclass IspNotifyTranslator
1 3 interface Notify
5 4 interface InitWindowMessage
4 5 interface InitCallback
4 6 interface InitSpNotifyCallback
3 7 interface InitWin32Event
2 8 interface Wait
1 9 interface GetEventHandle
end-class

create-guid IID_ISpDataKey {14056581-E16C-11D2-BB90-00C04F8EE6C0}
com subclass ISpDataKey
4 3 interface SetData
4 4 interface GetData
3 5 interface SetStringValue
3 6 interface GetStringValue
3 7 interface SetDWORD
3 8 interface GetDWORD
3 9 interface OpenKey
3 10 interface CreateKey
2 11 interface DeleteKey
2 12 interface DeleteValue
3 13 interface EnumKeys
3 14 interface EnumValues
end-class

create-guid IID_ISpRegDataKey {92A66E2B-C830-4149-83DF-6FC2BA1E7A5B}
IspDataKey subclass ISpRegDataKey
3 15 interface SetKey
end-class

create-guid IID_ISpObjectTokenCategory {2D3D3845-39AF-4850-BBF9-40B49780011D}
ISpDataKey subclass ISpObjectTokenCategory
3 15 interface SetId
2 16 interface GetId
3 17 interface GetDataKey
4 18 interface EnumTokens
2 19 interface SetDefaultTokenId
2 20 interface GetDefaultTokenId
end-class


create-guid IID_ISpObjectToken {14056589-E16C-11D2-BB90-00C04F8EE6C0}
ISpDataKey subclass ISpObjectToken
4 15 interface SetId
2 16 interface GetId
2 17 interface GetCategory
5 18 interface CreateInstance
6 19 interface GetStorageFileName
4 20 interface RemoveStorageFileName
2 21 interface Remove
6 22 interface IsUISupported
7 23 interface DisplayUI
3 24 interface MatchesAttributes
end-class

create-guid IID_ISpObjectTokenInit {B8AAB0CF-346F-49D8-9499-C8B03F161D51}
ISpObjectToken subclass ISpObjectTokenInit
4 25 interface InitFromDataKey
end-class

create-guid IID_IEnumSpObjectTokens {06B64F9E-7FDA-11D2-B4F2-00C04F797396}
com subclass IEnumSpObjectTokens
4 3 interface Next
2 4 interface Skip
1 5 interface Reset
2 6 interface Clone
3 7 interface Item
2 8 interface GetCount
end-class

create-guid IID_ISpObjectWithToken {5B559F40-E952-11D2-BB91-00C04F8EE6C0}
com subclass ISpObjectWithToken
2 3 interface SetObjectToken
2 4 interface GetObjectToken
end-class

create-guid IID_ISpResourceManager {93384E18-5014-43D5-ADBB-A78E055926BD}
com subclass ISpResourceManager
4 3 interface QueryService
3 4 interface SetObject
6 5 interface GetObject
end-class

0 enum SPET_LPARAM_IS_UNDEFINED
enum SPET_LPARAM_IS_TOKEN
enum SPET_LPARAM_IS_OBJECT
enum SPET_LPARAM_IS_POINTER
enum SPET_LPARAM_IS_STRING drop

0 enum SPEI_UNDEFINED
enum SPEI_START_INPUT_STREAM
enum SPEI_END_INPUT_STREAM
enum SPEI_VOICE_CHANGE
enum SPEI_TTS_BOOKMARK
enum SPEI_WORD_BOUNDARY
enum SPEI_PHONEME
enum SPEI_SENTENCE_BOUNDARY
enum SPEI_VISEME
enum SPEI_TTS_AUDIO_LEVEL 6 +
enum SPEI_TTS_PRIVATE drop 1
enum SPEI_MIN_TTS drop 15
enum SPEI_MAX_TTS drop 34
enum SPEI_END_SR_STREAM
enum SPEI_SOUND_START
enum SPEI_SOUND_END
enum SPEI_PHRASE_START
enum SPEI_RECOGNITION
enum SPEI_HYPOTHESIS
enum SPEI_SR_BOOKMARK
enum SPEI_PROPERTY_NUM_CHANGE
enum SPEI_PROPERTY_STRING_CHANGE
enum SPEI_FALSE_RECOGNITION
enum SPEI_INTERFERENCE
enum SPEI_REQUEST_UI
enum SPEI_RECO_STATE_CHANGE
enum SPEI_ADAPTATION
enum SPEI_START_SR_STREAM
enum SPEI_RECO_OTHER_CONTEXT
enum SPEI_SR_AUDIO_LEVEL 1 +
enum SPEI_SR_PRIVATE drop 34
enum SPEI_MIN_SR drop 52
enum SPEI_MAX_SR drop 30
enum SPEI_RESERVED1 2 +
enum SPEI_RESERVED2 drop 63
enum SPEI_RESERVED3 drop
1 SPEI_RESERVED1 lshift 2 2constant SPEI_FLAGS

class SPEVENT
    hsingle eEventId
    hsingle elParamType
    single ulStreamNum
    8 buffer: ullAudioStreamOffset
    single wParam
    single lParam
end-class

class SPSERIALIZEDEVENT
    hsingle eEventId
    hsingle elParamType
    single ulStreamNum
    8 buffer: ullAudioStreamOffset
    single SerializedwParam
    single SerializedlParam
end-class

class SPSERIALIZEDEVENT64
    hsingle eEventId
    hsingle elParamType
    single ulStreamNum
    8 buffer: ullAudioStreamOffset
    8 buffer: SerializedwParam
    8 buffer: SerializedlParam
end-class

create-guid IID_ISpEventSource {BE7A9CCE-5F9E-11D2-960F-00C04F8EE628}
ISpNotifySource subclass ISpEventSource
5 10 interface SetInterest
4 11 interface GetEvents
2 12 interface GetInfo
end-class

create-guid IID_ISpEventSink {BE7A9CC9-5F9E-11D2-960F-00C04F8EE628}
com subclass ISpEventSink
3 3 interface AddEvents
3 4 interface GetEventInterest
end-class

create-guid IID_ISpStreamFormat {BED530BE-2606-4F4D-A1C0-54C5CDA5566F}
com subclass ISpStreamFormat
4 3 interface Read
4 4 interface Write
4 5 interface Seek
2 6 interface SetSize
5 7 interface CopyTo
2 8 interface Commit
1 9 interface Revert
4 10 interface LockRegion
4 11 interface UnlockRegion
3 12 interface Stat
2 13 interface Clone
3 14 interface GetFormat
end-class

create-guid IID_ISpStream {12E3CCA9-7518-44C5-A5E7-BA5A79CB929E}
ISpStreamFormat subclass ISpStream
4 15 interface SetBaseStream
2 16 interface GetBaseStream
6 17 interface BindToFile
1 18 interface Close
end-class

create-guid IID_ISpStreamFormatConverter {678A932C-EA71-4446-9B41-78FDA6280A29}
ISpStreamFormat subclass ISpStreamFormatConverter
4 15 interface SetBaseStream
2 16 interface GetBaseStream
3 17 interface SetFormat
1 18 interface ResetSeekPosition
3 19 interface ScaleConvertedToBaseOffset
3 20 interface ScaleBaseToConvertedOffset
end-class

create-guid IID_ISpAudio {C05C768F-FAE8-4EC2-8E07-338321C12452}
ISpStreamFormat subclass ISpAudio
3 15 interface SetState
3 16 interface SetFormat
2 17 interface GetStatus
2 18 interface SetBufferInfo
2 19 interface GetBufferInfo
3 20 interface GetDefaultFormat
1 21 interface EventHandle
2 22 interface GetVolumeLevel
2 23 interface SetVolumeLevel
2 24 interface GetBufferNotifySize
2 25 interface SetBufferNotifySize
end-class

create-guid IID_ISpMMSysAudio {15806F6E-1D70-4B48-98E6-3B1A007509AB}
ISpAudio subclass ISpMMSysAudio
2 26 interface GetDeviceId
2 27 interface SetDeviceId
2 28 interface GetMMHandle
2 29 interface GetLineId
2 30 interface SetLineId
end-class

create-guid IID_ISpTranscript {10F63BCE-201A-11D3-AC70-00C04F8EE6C0}
com subclass ISpTranscript
2 3 interface GetTranscript
2 4 interface AppendTranscript
end-class

create-guid IID_ISpLexicon {DA41A7C2-5383-4DB2-916B-6C1719E3DB58}
com subclass ISpLexicon
5 3 interface GetPronunciations
5 4 interface AddPronunciation
5 5 interface RemovePronunciation
2 6 interface GetGeneration
4 7 interface GetGenerationChange
5 8 interface GetWords
end-class

create-guid IID_ISpContainerLexicon {8565572F-C094-41CC-B56E-10BD9C3FF044}
ISpLexicon subclass ISpContainerLexicon
3 9 interface AddLexicon
end-class

create-guid IID_ISpPhoneConverter {8445C581-0CAC-4A38-ABFE-9B2CE2826455}
ISpObjectWithToken subclass ISpPhoneConverter
3 5 interface PhoneToId
3 6 interface IdToPhone
end-class

create-guid IID_ISpVoice {6C44DF74-72B9-4992-A1EC-EF996E0422D4}
ISpEventSource subclass ISpVoice
3 13 interface SetOutput
2 14 interface GetOutputObjectToken
2 15 interface GetOutputStream
1 16 interface Pause
1 17 interface Resume
2 18 interface SetVoice
2 19 interface GetVoice
4 20 interface Speak
4 21 interface SpeakStream
3 22 interface GetStatus
4 23 interface Skip
2 24 interface SetPriority
2 25 interface GetPriority
2 26 interface SetAlertBoundary
2 27 interface GetAlertBoundary
2 28 interface SetRate
2 29 interface GetRate
2 30 interface SetVolume
2 31 interface GetVolume
2 32 interface WaitUntilDone
2 33 interface SetSyncSpeakTimeout
2 34 interface GetSyncSpeakTimeout
1 35 interface SpeakCompleteEvent
5 36 interface IsUISupported
6 37 interface DisplayUI
end-class

create-guid IID_ISpPhrase {1A5C0354-B621-4b5a-8791-D306ED379E53}
com subclass ISpPhrase
2 3 interface GetPhrase
2 4 interface GetSerializedPhrase
6 5 interface GetText
2 6 interface Discard
end-class

create-guid IID_ISpPhraseAlt {8FCEBC98-4E49-4067-9C6C-D86A0E092E3D}
ISpPhrase subclass ISpPhraseAlt
5 7 interface GetAltInfo
1 8 interface Commit
end-class

create-guid IID_ISpRecoResult {20B053BE-E235-43cd-9A2A-8D17A48B7842}
ISpPhrase subclass ISpRecoResult
2 7 interface GetResultTimes
6 8 interface GetAlternates
4 9 interface GetAudio
5 10 interface SpeakAudio
2 11 interface Serialize
3 12 interface ScaleAudio
2 13 interface GetRecoContext
end-class

create-guid IID_ISpGrammarBuilder {8137828F-591A-4A42-BE58-49EA7EBAAC68}
com subclass ISpGrammarBuilder
2 3 interface ResetGrammar
6 4 interface GetRule
2 5 interface ClearRule
3 6 interface CreateNewState
8 7 interface AddWordTransition
6 8 interface AddRuleTransition
4 9 interface AddResource
2 10 interface Commit
end-class

create-guid IID_ISpRecoGrammar {2177DB29-7F45-47D0-8554-067E91C80502}
ISpGrammarBuilder subclass ISpRecoGrammar
3 11 interface GetGrammarId
2 12 interface GetRecoContext
3 13 interface LoadCmdFromFile
4 14 interface LoadCmdFromObject
6 15 interface LoadCmdFromResource
3 16 interface LoadCmdFromMemory
6 17 interface LoadCmdFromProprietaryGrammar
4 18 interface SetRuleState
3 19 interface SetRuleIdState
3 20 interface LoadDictation
1 21 interface UnloadDictation
2 22 interface SetDictationState
4 23 interface SetWordSequenceData
2 24 interface SetTextSelection
3 25 interface IsPronounceable
2 26 interface SetGrammarState
3 27 interface SaveCmd
2 28 interface GetGrammarState
end-class

create-guid IID_ISpRecoContext {F740A62F-7C15-489E-8234-940A33D9272D}
ISpEventSource subclass ISpRecoContext
2 13 interface GetRecognizer
4 14 interface CreateGrammar
2 15 interface GetStatus
2 16 interface GetMaxAlternates
2 17 interface SetMaxAlternates
4 18 interface SetAudioOptions
4 19 interface GetAudioOptions
3 20 interface DeserializeResult
5 21 interface Bookmark
3 22 interface SetAdaptationData
2 23 interface Pause
2 24 interface Resume
3 25 interface SetVoice
2 26 interface GetVoice
3 27 interface SetVoicePurgeEvent
3 28 interface GetVoicePurgeEvent
2 29 interface SetContextState
2 30 interface GetContextState
end-class

create-guid IID_ISpProperties {5B4FB971-B115-4DE1-AD97-E482E3BF6EE4}
com subclass ISpProperties
3 3 interface SetPropertyNum
3 4 interface GetPropertyNum
3 5 interface SetPropertyString
3 6 interface GetPropertyString
end-class

create-guid IID_ISpRecognizer {C2B5F241-DAA0-4507-9E16-5A1EAA2B7A5C}
ISpProperties subclass ISpRecognizer
2 7 interface SetRecognizer
2 8 interface GetRecognizer
3 9 interface SetInput
2 10 interface GetInputObjectToken
2 11 interface GetInputStream
2 12 interface CreateRecoContext
2 13 interface GetRecoProfile
2 14 interface SetRecoProfile
1 15 interface IsSharedInstance
2 16 interface GetRecoState
2 17 interface SetRecoState
2 18 interface GetStatus
4 19 interface GetFormat
5 20 interface IsUISupported
6 21 interface DisplayUI
2 22 interface EmulateRecognition
end-class



\ Forth Word and Objects to make this simpler

class spvoice
  variable vtable  \ pointer to COM virtual function lookup table
  variable wavebuf  \ audio streaming buffer
  single wavebufoff \ offset into the buffer
  single maxwavebuf \ size of the buffer
  waveformatex builds waveex  \ audio format structure
  ISpVoice builds voice
  variable rate
  variable volume
  single flags
  512 buffer: sbuf \ unicode converter buffer
end-class

create adwKHZ   \ possible frequencies
8000 , 11025 , 12000 , 16000 , 22050 , 24000 , 32000 , 44100 , 48000 ,
create alawadwkhz
8000 , 11025 , 22050 , 44100 ,

\ Our Own Com Istream
\ Note: Most of the callbacks are not used--may be implemented later
create mystreamtbl 19 cells allot

:noname _param_1 @ IID_ISpStreamFormat @ = if
   _param_0 _param_2 ! 0 else E_NOINTERFACE then ; 3 cb: squeryinterface
:noname 0 ; 1 cb: saddref
:noname 0 ; 1 cb: srelease
:noname
  _param_0 using spvoice wavebuf @
  _param_0 using spvoice wavebufoff
  _param_0 using spvoice maxwavebuf mod + _param_1 _param_2 cmove
  _param_2 +to _param_0 using spvoice wavebufoff 0 ; 4 cb: sread

:noname
  _param_0 using spvoice maxwavebuf _param_0 using spvoice wavebufoff -
  _param_2 < if  \ buffer too small!
    _param_0 using spvoice wavebuf @
    _param_0 using spvoice maxwavebuf
    _param_0 using spvoice waveex navgbytespersec + resize if
      drop STG_E_CANTSAVE exit else
      _param_0 using spvoice wavebuf !
      _param_0 using spvoice waveex navgbytespersec
      +to _param_0 using spvoice maxwavebuf then
  then
  _param_0 using spvoice wavebuf @
  _param_0 using spvoice wavebufoff
  _param_0 using spvoice maxwavebuf mod + _param_1 swap _param_2 cmove
  _param_2 +to _param_0 using spvoice wavebufoff 0 ; 4 cb: swrite

:noname _param_3 0= if _param_1 to _param_0 using spvoice wavebufoff
  0 _param_4 ! then 0 ; 5 cb: sseek
:noname E_NOTIMPL  ; 2 cb: ssetsize
:noname E_NOTIMPL  ; 5 cb: scopyto
:noname E_NOTIMPL  ; 2 cb: scommit
:noname E_NOTIMPL  ; 1 cb: srevert
:noname E_NOTIMPL  ; 4 cb: slockregion
:noname E_NOTIMPL  ; 4 cb: sunlockregion
:noname E_NOTIMPL  ; 3 cb: sstat
:noname E_NOTIMPL  ; 2 cb: sclone
:noname _param_2 0= if E_POINTER exit then
  CLSID_SpWaveFormatEx _param_1 ! 18 cotaskmemalloc _param_2 !
  _param_0 using spvoice waveex addr _param_2 @ 18 cmove 0 ; 3 cb: sgetformat


\ build the vtable
squeryinterface mystreamtbl !
saddref mystreamtbl 1 cells + !
srelease mystreamtbl 2 cells + !
sread mystreamtbl 3 cells + !
swrite mystreamtbl 4 cells + !
sseek mystreamtbl 5 cells + !
ssetsize mystreamtbl 6 cells + !
scopyto mystreamtbl 7 cells + !
scommit mystreamtbl 8 cells + !
srevert mystreamtbl 9 cells + !
slockregion mystreamtbl 10 cells + !
sunlockregion mystreamtbl 11 cells + !
sstat mystreamtbl 12 cells + !
sclone mystreamtbl 13 cells + !
sgetformat mystreamtbl 14 cells + !

\ dummy callback for accidental use
srevert mystreamtbl 15 cells + !
srevert mystreamtbl 16 cells + !
srevert mystreamtbl 17 cells + !
srevert mystreamtbl 18 cells + !


spvoice reopen
  : Init
    mystreamtbl vtable !
    CLSID_SpVoice 0 CLSCTX_ALL IID_ISpVoice voice pointer :: cocreateinstance
    if z" SpVoice" last-error-alert then ( hcon z" Unable to Allocate Voice!" ebox then)
      \ speaking flags.  Default is syncronus, Queued, with XML tags
    8 to flags ;

\ This is a big ugly guy.  He basically sets the waveformatex structure to
\ whatever format you want -- not very elegant, but neither is the structure
\ I only have it work with formats I know (namely, PCM, alaw, mulaw)

  : Set-waveFormat ( n -- ) \ sets the wave format ** SPEI enumberation
    dup SPSF_8kHz8BitMono 1 - SPSF_48kHz16BitStereo 1 + within if  \ normal compression
     WAVE_FORMAT_PCM to waveex wformattag
     dup SPSF_8kHz8BitMono - 1 and 1+ dup to waveex nchannels to waveex nblockalign
     dup SPSF_8kHz8BitMono - 4 / cells adwkhz + @ to waveex nsamplespersec
     dup 2 and if 16 to waveex wbitspersample waveex nblockalign 2 * to waveex nblockalign
       else 8 to waveex wbitspersample then
     waveex nblockalign waveex nsamplespersec * to waveex nAvgBytesPerSec
     0 to waveex cbsize
    then
    dup SPSF_CCITT_ALaw_8kHzMono 1 - SPSF_CCITT_ALaw_44kHzStereo 1 + within if \ alaw compression
     6 to waveex wformattag
     dup SPSF_CCITT_ALaw_8kHzMono - 1 and 1+ dup to waveex nchannels to waveex nblockalign
     dup SPSF_CCITT_ALaw_8kHzMono - 2 / cells alawadwkhz + @ to waveex nsamplespersec
     8 to waveex wbitspersample
     waveex nblockalign waveex nsamplespersec * to waveex navgbytespersec
     0 to waveex cbsize
    then
    dup SPSF_CCITT_uLaw_8kHzMono 1 - SPSF_CCITT_uLaw_44kHzStereo 1 + within if  \ ulaw compression
     7 to waveex wformattag
     dup SPSF_CCITT_uLaw_8kHzMono - 1 and 1+ dup to waveex nchannels to waveex nblockalign
     dup SPSF_CCITT_uLaw_8kHzMono - 2 / cells alawadwkhz + @ to waveex nsamplespersec
     8 to waveex wbitspersample
     waveex nblockalign waveex nsamplespersec * to waveex navgbytespersec
     0 to waveex cbsize
    then
    drop ;

  : Set-Rate ( n -- ) \ sets the rate that a voice speaks  -10 to 10
    rate ! voice pointer @ if rate @ voice setrate drop then ;
  : Get-Rate ( -- n ) \ gets the rate of a voice
    voice pointer @ if rate voice getrate drop then rate @ ;
  : Set-Volume ( n -- ) \ sets the volume ( number is a percentage of what's normal )
    volume ! voice pointer @ if volume @ voice setVolume drop then ;
  : Get-Volume ( -- n ) \ fetches the volume
    voice pointer @ if volume voice getvolume drop then volume @ ;

  : Get-Eventhndl ( -- n ) \ event handle for async speaking
    voice pointer @ if voice speakcompleteevent else 0 then ;

  : Set-Async ( -- ) flags 1 or to flags ;
  : +XML-tags ( -- ) flags 8 or to flags ;
  : -XML-tags ( -- ) flags 8 and if flags 8 xor to flags then ;
  : Global-XML ( -- ) flags 32 or to flags ;
  : Local-XML ( -- ) flags 32 and if flags 32 xor to flags then ;

  : Speak ( str len -- )
    voice pointer @ if 500 sbuf !
    0 MB_PRECOMPOSED 2swap sbuf 4 + sbuf :: multibytetowidechar sbuf !
    sbuf @ 2 * sbuf 4 + + 0 swap !
    sbuf 4 + flags 0 voice speak drop
    else 2drop then ;

  : Speak-File ( str len -- ) \ speaks from a text file  takes filename
    voice pointer @ if 500 sbuf !
    0 MB_PRECOMPOSED 2swap sbuf 4 + sbuf :: multibytetowidechar sbuf !
    sbuf @ 2 * sbuf 4 + + 0 swap !
    sbuf 4 + flags 4 or 0 voice speak drop
    else 2drop then ;

  : purge ( -- )
    voice pointer @ if 0 2 0 voice speak drop then ;

  : Pause ( -- )
    voice pointer @ if voice pause drop then ;
  : Resume ( -- )
    voice pointer @ if voice resume drop then ;

  : done? ( -- flag ) \ are we done speaking (for async stuff)
    sbuf 0 voice getstatus drop
    sbuf 3 cells + @ 1 - not ;

  : Curr-PhID ( -- n ) \ current phenome we're speaking (I have NO IDEA what you'd use this for)
    sbuf 0 voice getstatus drop
    sbuf 10 cells + @ ;
  : Curr-vismeid ( -- flag ) \ current vismeid **se previous function's comment
    sbuf 0 voice getstatus drop
    sbuf 11 cells + @ ;

 \ Outputs the audio to a buffer NOTICE** the audio format will be the same as
 \ the format described in waveex**
  : voice>buffer ( -- )
    vtable 0 voice setoutput if hcon z" Unable to Defer Voice Audio!" ebox exit then
    wavebuf @ ?dup if free drop then
    waveex navgbytespersec to maxwavebuf
    maxwavebuf allocate drop wavebuf ! \ setup a new buffer
    0 to wavebufoff ;

  : buf>file ( str len -- ) \ saves the buffer to a wave file
    r/w create-file drop 
    s" RIFF" 2 pick write-file drop
    wavebufoff 50 + sbuf ! sbuf 4 2 pick write-file drop
    s" WAVE" 2 pick write-file drop
    s" fmt " 2 pick write-file drop 
    18 sbuf ! sbuf 4 2 pick write-file drop
    waveex addr waveformatex sizeof 2 pick write-file drop
    s" fact" 2 pick write-file drop
    4 sbuf ! sbuf 4 2 pick write-file drop
    28672 sbuf ! sbuf 4 2 pick write-file drop
    s" data" 2 pick write-file drop
    wavebufoff sbuf ! sbuf 4 2 pick write-file drop
    wavebuf @ wavebufoff 2 pick write-file drop
    close-file drop ;

  : destruct ( --  )
    destruct
    wavebuf @ free drop ;
end-class

\ Here's the Speech Recognition EZ object

class sprecognizer
  \ this first part must be exactly as the voice object, so we can use
  \ the save com object to interface
  variable vtable  \ pointer to COM virtual function lookup table
  variable wavebuf  \ audio streaming buffer
  single wavebufoff \ offset into the buffer
  single maxwavebuf \ size of the buffer
  waveformatex builds waveex  \ audio format structure
  spevent builds event \ SR events
  256 buffer: Sbuf
  variable temp
  variable element
  Isprecognizer builds recognizer
  Isprecoresult builds result
  Isprecocontext builds context
  ISprecogrammar builds grammar
  8 buffer: eventflags
  single textflags


  : Init ( -- )
    mystreamtbl vtable !
    CLSID_SpSharedRecognizer 0 CLSCTX_ALL IID_ISpRecognizer recognizer pointer
    :: cocreateinstance  if hcon z" Unable to Allocate Voice!" ebox exit then
    context pointer recognizer createrecocontext
    if hcon z" Cannot make Context!" ebox exit then
    0 0 grammar pointer context creategrammar if hcon
      z" Cannot make Grammar" ebox exit then ;

  : Resume ( -- ) 0 context resume drop ;
  : Pause ( -- ) 0 context pause drop ;

  : Get-Profile ( -- addr ) \ returns address to a ispobjecttoken object
    temp recognizer getrecoProfile drop temp @ ;
  : Get-Profile ( addr -- ) \ set the profile with a ispobjecttoken object
    recognizer setrecoProfile drop ;
  : STATE ( -- n ) \ returns the engines state
    temp recognizer GetRecoState drop temp @ ;
  : Set-State ( n -- ) \ changing the state
    recognizer SetRecoState drop ;

  : unicode> ( addr -- str len ) 0 sbuf !
    begin dup 1 sbuf append dup 2+ swap w@ 0= until drop sbuf count 1 - ;

  : Load-Dictation ( zstr -- f ) \ loads type of dictation ( if zstr is zero, loads default)
    0 grammar loaddictation ;
  : Unload-Dictation ( -- )
    grammar unloaddictation drop ;

  : Activate-Dict ( -- )
    1 grammar setdictationstate drop ;
  : Disactivate-Dict ( -- )
    0 grammar setdictationstate drop ;

  : Load-Grammar-File ( str len -- )
    drop 0 grammar LoadCmdFromFile drop ;

 : +eflags ( n -- ) \ adds a flag to the event flags
    dup 32 / if 32 - eventflags 4 + else eventflags then
    dup @ rot 1 swap lshift or swap !
    eventflags 2@ 2dup context setinterest drop ;
  : -eflags ( n -- ) \ delete a flag to the event flags
    dup 32 / if 32 - eventflags 4 + else eventflags then
    dup @ rot 1 swap lshift 2dup and if xor else drop then swap !
    eventflags 2@ 2dup context setinterest drop ;

  : Get-Event ( -- n )  0 temp ! \ true if we have an event in the queue
    result pointer @ if result ireleaseref drop 0 result pointer ! then
    event elparamtype 4 = if event lparam :: cotaskmemfree then
    event addr spevent sizeof erase
    element @ if element @ :: cotaskmemfree 0 element ! then
    1 event addr temp context getevents drop
    event elparamtype 2 = if event lparam result pointer !
      element result GetPhrase drop then temp @ ;

  : Event-type ( -- n ) event eeventid ; \ type of event
  : Event-str ( -- str len ) \ gets what we've recognized
    event elparamtype 2 = if
      -1 -1 textflags temp 0 result gettext if s" " exit else
        temp @ unicode> exit then then
    event elparamtype 4 = if event lparam unicode> exit else s" " then ;
  : Event>Rule ( -- addr )
      element @ 10 cells + 2 + ;
  : Rule-name ( addr -- str len ) @ unicode> ;
  : Rule-id ( addr -- id ) 4 + @ ;
  : Rule-confidence ( addr -- n )  7 cells + @ ;
  : Rule-Sibling ( addr -- addr ) 4 cells + @ ;
  : Rule-Child ( addr -- addr ) 5 cells + @ ;


  : Speak-Result ( -- )
    result pointer @ if
      0 0 0 0 result speakaudio drop then ;

  : destruct ( -- )
    element @ ?dup if :: cotaskmemfree then
    result pointer @ if result ireleaseref drop then
    grammar ireleaseref drop
    context ireleaseref drop
    recognizer ireleaseref drop ;

end-class





