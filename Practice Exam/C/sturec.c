// read text from input (FILE *)
// write sturec_t structs to output (filedesc)

int makeStuFile(char *inFile, char *outFile)
{
    sturec_t stu;

    // attempt to open input file
    FILE *in;
    if ((in = fopen(inFile,"r")) == NULL) return -1;

    // attempt to open named file
    int out;
    if ((out = open(outFile, O_CREAT|O_WRONLY, 0644)) < 0) return -2;

    // read text from input, write student records to output
    char line[100];
    while (fgets(line,99,in) != NULL) {
        int n = sscanf(line, "%d %s %d %f",
                &(stu.id), &(stu.name[0]), &(stu.degree), &(stu.wam));
        if (n != 4) return -3;
        write(out, &stu, sizeof(sturec_t));
    }

    // close files
    fclose(in);
    close(out);
    return 0;
}

// int makeStuFile(char *inFile, char *outFile){
//     sturec_t stu;

//     //attempts to open file text input file for reading 
//     FILE*in;
//     if((in = fopen(inFile, "r")) == NULL){
//         return -1;
//     }

//     //attempt to open binary output fil for writing
//     int out;
//     if((out = open(outFile, O_CREAT|O_WRONLY, 0644)) < 0){
//         return -2;
//     }
//     // read text from input, write student records to output
//     char[100] line = NULL;
//     while ( fgets(line,99,in) != NULL){
//         int n = sscanf( line, "%d,%s,%d,%f", 
//             &(stu.id), &(stu.name[0]), &(stu.degree), &(stu.wam));
//         if(n != 4){
//             return -3;
//         }
//         write(out, &stu, sizeof(sturec_t));
//     }

//     fclose(in);
//     close(out);
//     return 0;

// }