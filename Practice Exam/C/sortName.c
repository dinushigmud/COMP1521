// Sort students by name

// simple bubble sort

void sortByName(Students ss)
{
    int nswaps;
    int last = ss->nstu;
    do {
        nswaps = 0;
        for (int i = 1; i < last; i++) {
            if (strcmp(ss->recs[i].name, ss->recs[i-1].name) < 0) {
                struct _stu_rec tmp;
                tmp = ss->recs[i];
                ss->recs[i] = ss->recs[i-1];
                ss->recs[i-1] = tmp;
                nswaps++;
            }
        }
        last--;
    } while (nswaps > 0);
}

/*OR

// using qsort() defined in library

int cmp (const void *a, const void *b)
{
     struct _stu_rec *aa = (struct _stu_rec *)a;
     struct _stu_rec *bb = (struct _stu_rec *)b;
     return strcmp(aa->name, bb->name);
}
void sortByName(Students ss)
{
    qsort(ss->recs, ss->nstu, sizeof(struct _stu_rec), cmp);
}
*/