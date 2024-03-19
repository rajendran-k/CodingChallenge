def getvalue(obj, values):
    after_split = values.split('/')
    result = obj
    try:

        for  i in after_split:
            if isinstance(result, dict) and i in result:
                result = result[i]
            else:
                result = None
                break
        return result
    except :
        print('key not present')


data = {"a": {"b": {"c": "d"}}}

print(getvalue(data,'a/b/c'))
data = {"a": {"b": {"c": {"d"}}}}
print(getvalue(data,'a/b/c'))
data = {"a": {"b": {"c": {"d"}}}}
print(getvalue(data,'a/b/d'))
obj2 = {"a": {"b": "c"}}
key2 = "a/b/c"
print(getvalue(obj2,key2))
