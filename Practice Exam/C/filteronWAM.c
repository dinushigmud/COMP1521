// return new Students object based on removing all
//   student with WAM < minWAM from original list
Students filterOnWAM(Students ss, float minWAM)
{
    // how many records in result
    int ns = 0;
    for (int i = 0; i < ss->nstu; i++) {
        if (ss->recs[i].wam >= minWAM) ns++;
    }

    // make an arrayfor filtered sturec_t's
    StuRec recs;
    if ((recs = malloc(ns*sizeof(sturec_t))) == NULL) {
        fprintf(stderr, "Can't allocate Students\n");
        return NULL;
    }

    // copy valid records to new array
    int j = 0;
    for (int i = 0; i < ss->nstu; i++) {
        if (ss->recs[i].wam >= minWAM) {
            recs[j++] = ss->recs[i];
        }
    }

    // make students_t object
    Students new;
    if ((new = malloc(sizeof(students_t))) == NULL) {
        fprintf(stderr, "Can't allocate Students\n");
        free(recs);
        return NULL;
    }
    new->nstu = ns;
    new->recs = recs;

    return new;
}
