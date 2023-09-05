def hexdecode (input):
    #print (type(input))
    #print (input)
    return int(input,16)

def str_hexdecode(input):
    if input[0] != ':' :
        return "not :"
    elif input[7:9] == '01':
        return "EOF"
    elif input[7:9] != '00':
        return "not 00"
    else :
        #return [hexdecode(input[i,i+2]) for i in range(9, 9+hexdecode (input[1:3]),2)]
        #return [hexdecode(input[i:i+2]) for i in range(0,5)]
        return [hexdecode(input[i:i+2]) for i in range(9,9+2*hexdecode(input[1:3]),2)]
    
with open("111.hex", "r") as f:
    text = f.readlines()

#for i in text:
#    print(i[:-1])

res=[]
print(text[0][9:11])
#res.append(text[0])

print(res)

##print (hexdecode(text[0][9:11]))
##print (str_hexdecode(text[0]))
##res= res+str_hexdecode(text[0])
##res= res+str_hexdecode(text[1])
i=0
ii=0
while ii!=1:
    o=str_hexdecode(text[i])
    i+=1
    #print(i)
    #print(o)
    if o == "EOF" : ii=1
    elif o!="not 00": res+=o
    
print(res[0:100])
