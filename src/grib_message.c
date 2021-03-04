/*
 * Copyright 2005-2018 ECMWF.
 *
 * This software is licensed under the terms of the Apache Licence Version 2.0
 * which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.
 *
 * In applying this licence, ECMWF does not waive the privileges and immunities granted to it by
 * virtue of its status as an intergovernmental organisation nor does it submit to any jurisdiction.
 */
 
/*
 * C Implementation: ensemble_mean
 *
 * Description: index a GRIB file, select a specific parameter and compute ensemble mean.
 *
 */
 
#include "eccodes.h"
 
int main(int argc, char * argv[])
{
    int ret;
    int i, j;
    int count=0;
    size_t shortNameSize, numberSize, values_len=0;
    char** shortName;
    long* number;
    double* values;
    double* result=NULL;
    double min=1e13,max=-1e13,avg=0;
    codes_index* index;
    codes_handle* h=NULL;
 
    if (argc<2) return 1;
 
    /* create index of file contents for shortName  */
    index = codes_index_new_from_file(0, argv[1], "shortName",&ret);
    CODES_CHECK(ret,0);
 
    /* get size of "shortName" list */
    CODES_CHECK(codes_index_get_size(index, "shortName", &shortNameSize),0);
    printf("grib contains %lu different parameters\n",shortNameSize);
    /* allocate memory for "shortName" list */
    shortName = (char**) malloc(shortNameSize * sizeof(char*));
    /* get list of "shortName" */
    CODES_CHECK(codes_index_get_string(index, "shortName", shortName, &shortNameSize),0);
    for (i=0;i<shortNameSize;i++)
        printf("shortName %s\n",shortName[i]);
 

    /* select T2m with shortName 165 */
    CODES_CHECK(codes_index_select_string(index, "shortName", "2r"), 0);



            /* create handle for next GRIB message */
        h=codes_handle_new_from_index(index, &ret);
        if (ret) {
            printf("Error: %s\n", codes_get_error_message(ret));
            exit(ret);
        }
 
        /* get the size of the values array */
        CODES_CHECK(codes_get_size(h, "values", &values_len), 0);
 
        /* allocate memory for the GRIB message */
        values = (double*)malloc(values_len * sizeof(double));
 
        /* allocate memory for result */
        /*if ( i == 0 ) {
            result = (double *)calloc(values_len, sizeof(double));
        }*/
 
        /* get data values */
        CODES_CHECK(codes_get_double_array(h, "values", values, &values_len), 0);
 
        /* add up values */
        for (j = 0; j < values_len; j++)
            //result[j] = result[j] + values[j];
            count++;
        printf("values count : %d\n", count);
        for (j = 1e5; j < (1e5+10); j++)
            //result[j] = result[j] + values[j];
            printf("values : %f\n", values[j]);;
        
        /* free memory and GRIB message handle */
        free(values);
        CODES_CHECK(codes_handle_delete(h), 0);
 

    /* finally free all other memory */
    for (i=0;i<shortNameSize;i++)
        free(shortName[i]);
    free(shortName);
    //free(number);
    //free(result);
    codes_index_delete(index);
 
    return 0;
}