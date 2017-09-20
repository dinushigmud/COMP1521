// myls.c ... my very own "ls" implementation

#include <stdlib.h>
#include <stdio.h>
#include <bsd/string.h>
#include <unistd.h>
#include <fcntl.h>
#include <dirent.h>
#include <grp.h>
#include <pwd.h>
#include <sys/stat.h>
#include <sys/types.h>

#define MAXDIRNAME 100
#define MAXFNAME   200
#define MAXNAME    20

char *rwxmode(mode_t, char *);
char *username(uid_t, char *);
char *groupname(gid_t, char *);

int main(int argc, char *argv[])
{
   // string buffers for various names
   char dirname[MAXDIRNAME];
   char uname[MAXNAME+1]; // UNCOMMENT this line
   char gname[MAXNAME+1]; // UNCOMMENT this line
   char mode[MAXNAME+1]; // UNCOMMENT this line

   // collect the directory name, with "." as default
   if (argc < 2)
      strlcpy(dirname, ".", MAXDIRNAME);
   else
      strlcpy(dirname, argv[1], MAXDIRNAME);

   // check that the name really is a directory
   struct stat info;
   if (stat(dirname, &info) < 0)
      { perror(argv[0]); exit(EXIT_FAILURE); }
   if ((info.st_mode & S_IFMT) != S_IFDIR)
      { fprintf(stderr, "%s: Not a directory\n",argv[0]); exit(EXIT_FAILURE); }

   // open the directory to start reading
   DIR *df; // UNCOMMENT this line
   // ... TODO ...
   df = opendir(dirname);



   // read directory entries
   struct dirent *entry; // UNCOMMENT this line
   struct stat entrySTAT;
   while ((entry = readdir(df)) != NULL) {
      if (entry->d_name[0] == '.') continue;
      char filepath[MAXDIRNAME+MAXFNAME];
      filepath[0] = '\0';
      strcat(filepath, dirname);
      strcat(filepath, "/");
      strcat(filepath, entry->d_name);
      //printf("%s\n", filepath);
      if(lstat(filepath, &entrySTAT)) printf("ERROR\n");
      printf("%s  %-8.8s %-8.8s %8lld  %s\n",
         rwxmode(entrySTAT.st_mode, mode),
         username(entrySTAT.st_uid, uname),
         groupname(entrySTAT.st_gid, gname),
         (long long)entrySTAT.st_size,
         entry->d_name);
   }

   // finish up
   closedir(df); // UNCOMMENT this line
   return EXIT_SUCCESS;
}

// convert octal mode to -rwxrwxrwx string
char *rwxmode(mode_t mode, char *str)
{
  // printf("%lo\n", (unsigned long)mode);
   char cat[4];
   switch (mode & S_IFMT) {
      case S_IFBLK:  strcpy(cat, "b");   break;
      case S_IFCHR:  strcpy(cat, "c");   break;
      case S_IFDIR:  strcpy(cat, "d");   break;
      case S_IFIFO:  strcpy(cat, "p");   break;
      case S_IFLNK:  strcpy(cat, "l");   break;
      case S_IFREG:  strcpy(cat, "-");   break;
      case S_IFSOCK: strcpy(cat, "s");   break;
      default:       strcpy(cat, "?");   break;
   }
   str[0] = '\0';
   strcat(str, cat);
   int digit[3];
   digit[2] = mode % 8;
   digit[1] = (mode/8) % 8;
   digit[0] = (mode/64) % 8;

   for (int i = 0; i < 3; i++) {
      switch(digit[i]) {
         case 0 : strcpy(cat, "---");   break;
         case 1 : strcpy(cat, "--x");   break;
         case 2 : strcpy(cat, "-w-");   break;
         case 3 : strcpy(cat, "-wx");   break;
         case 4 : strcpy(cat, "r--");   break;
         case 5 : strcpy(cat, "r-x");   break;
         case 6 : strcpy(cat, "rw-");   break;
         case 7 : strcpy(cat, "rwx");   break;
         default: strcpy(cat, "???");   break;
      }
      strcat(str, cat);
   }
  // printf(" id s%s\n", str);
   return str;

}

// convert user id to user name
char *username(uid_t uid, char *name)
{
   struct passwd *uinfo = getpwuid(uid);
   if (uinfo == NULL)
      snprintf(name, MAXNAME, "%d?", (int)uid);
   else
      snprintf(name, MAXNAME, "%s", uinfo->pw_name);
   return name;
}

// convert group id to group name
char *groupname(gid_t gid, char *name)
{
   struct group *ginfo = getgrgid(gid);
   if (ginfo == NULL)
      snprintf(name, MAXNAME, "%d?", (int)gid);
   else
      snprintf(name, MAXNAME, "%s", ginfo->gr_name);
   return name;
}
