
// sort students records by WAM, then by name

// using bubblesort

int stucmp(StuRec a, StuRec b)
{
    if (a->wam < b->wam)
        return -1;
    else if (a->wam > b->wam)
        return 1;
    else
        return strcmp(a->name,b->name);
}

void sortByWAM(Students ss)
{
    int nswaps;
    int last = ss->nstu;
    do {
        nswaps = 0;
        for (int i = 1; i < last; i++) {
            if (stucmp(&(ss->recs[i]), &(ss->recs[i-1])) < 0) {
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

int cmp(const void *a, const void *b)
{
     struct _stu_rec *aa = (struct _stu_rec *)a;
     struct _stu_rec *bb = (struct _stu_rec *)b;
     return stucmp(aa, bb);
}
void sortByWAM(Students ss)
{
    qsort(ss->recs, ss->nstu, sizeof(struct _stu_rec), cmp);
}*/

