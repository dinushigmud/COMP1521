// build a collection of student records from a file descriptor
Students getStudents(int in)
{
    int ns;  // count of #students

    // Make a skeleton Students struct
    Students ss;
    if ((ss = malloc(sizeof (struct _students))) == NULL) {
        fprintf(stderr, "Can't allocate Students\n");
        return NULL;
    }

    // count how many student records
    int stu_size = sizeof(struct _stu_rec);
    sturec_t s;
    ns = 0;
    while (read(in, &s, stu_size) == stu_size) ns++;
    ss->nstu = ns;
    if ((ss->recs = malloc(ns*stu_size)) == NULL) {
        fprintf(stderr, "Can't allocate Students\n");
        free(ss);
        return NULL;
    }

    // read in the records
    lseek(in, 0L, SEEK_SET);
    for (int i = 0; i < ns; i++)
        read(in, &(ss->recs[i]), stu_size);
    close(in);
    return ss;
}

// // Above is a simple, slightly inefficient, solution

// Students getStudents(int in)
// {
//     int ns;

//     //Make a skeleton student struct
//     Students ss;
//     if((ss = malloc(sizeof (struct _students)) == NULL){
//         fprintf(stderr, "Can't Locate Students\n");
//         free(ss);
//         return NULL
//     }

//     //count how many student records
//     int stu_size = sizeof(struct _stu_rec);
//     sturec_t s;
//     ns = 0;
//     while(read(in, &s, stu_size) == stu_size){
//         ns++;
//     }

//     ss->nstu = ns;
//     if ((ss->recs = malloc(ns*stu_size)) == NULL) {
//         fprintf(stderr, "Can't allocate Students\n");
//         free(ss);
//         return NULL;
//     }

//     lseek(in, 0L, SEEK_SET);
//     for(int i =0; i < ns; i++){}
//         read(in, &(ss->recs[i]), stu_size);
//     }
//     close(in)
// }