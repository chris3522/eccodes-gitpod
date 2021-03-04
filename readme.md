ECCODES Gitpod workspace-image 
==============================
Provide .gitpod.Dockerfile for ECCODES library  


## Make grib.out example, run: 
set CmakeLists.txt with correct file.c name at line 9 and run 
```shell 
bash build.sh
cd build
./grib.out ../data/my_grib_file.grib2
``` 
## About ECCODES
- A grib file can contain several messages
- First of all it is necessary to iterate in this file to extract each message to feed a code_handle per message : while((h = codes_handle_new_from_file(0,f,PRODUCT_GRIB,&err)) != NULL) 
- Second you must identify keys in one message with a key iterator function : kiter=codes_keys_iterator_new and then codes_keys_iterator_next(kiter)  
- Then you need to create an index with index function and a list of keys: index = codes_index_new_from_file   
- Fourth you have to select a key=value and set the index with these select key=value in an index function : codes_index_select_string
- Fifth create a specific code_handle with this specific index
- Sixth get values with codes_get_size and codes_get_double_array
- Seven iterate in values array