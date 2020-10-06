import speech_recognition as s
import pyaudio


sr=s.Recognizer()#this willl recognise our audio 



with s.Microphone() as source:#here we are intialisng our source to microphone we can also intialise to some file 
    print("Hey Do You wanna Speak I am listening : ")
    audio =sr.listen(source) #listening to source and saving it to audio
    try:
        
        text =sr.recognize_google(audio,language="eng-in") #recogniser here will convert audio into text part
        print("Ohh I recorded your voice as text :{}".format(text))


    except:
        print("sorry can't hear you")
