VERBOSE		=	false

CC		=	gcc
FLAGS		=
OFLAGS		=

LINKCC		=	gcc

BASE		=	linux
OBJDIR		=	obj/O.$(BASE)
BINOBJDIR	=	$(OBJDIR)/bin
SRCDIR		=	src
BINDIR		=	bin

MAINOBJ		=	main.o
MAINOBJFILES	=	$(addprefix $(BINOBJDIR)/,$(MAINOBJ))
MAINNAME	=	HalloWorld

MAINSRC		=	$(addprefix $(SRCDIR)/,$(MAINOBJ:.o=.c))

MAINFILE	=	$(BINDIR)/$(MAINNAME).$(BASE)


#-----------------------------------------------------------------------------
# Create folders if needed
#-----------------------------------------------------------------------------

$(OBJDIR):	
		@-mkdir -p $(OBJDIR)

$(BINOBJDIR):	$(OBJDIR)
		@-mkdir -p $(BINOBJDIR)

$(BINDIR):	
		@-mkdir -p $(BINDIR)

#-----------------------------------------------------------------------------
# Rules
#-----------------------------------------------------------------------------

ifeq ($(VERBOSE),false)
.SILENT:	$(MAINFILE)
endif

all: 		$(MAINFILE)

.PHONY: cleanbin
cleanbin:       $(BINDIR) 
		@echo "-> remove binary $(MAINFILE)"
		@-rm -f $(MAINFILE)

.PHONY: clean
clean:		cleanbin $(BINOBJDIR)
		@echo "-> remove objective files"
		@-rm -f $(BINOBJDIR)/*.o && rmdir $(BINOBJDIR)


$(MAINFILE):	$(BINDIR) $(BINOBJDIR) $(MAINOBJFILES)
		@echo "-> linking $@"
		$(LINKCC) $(MAINOBJFILES) \
		$(OFLAGS) $(LDFLAGS) $(LINKCC_o)$@

$(BINOBJDIR)/%.o:	$(SRCDIR)/%.c $(BINOBJDIR)
		@echo "-> compiling $@"
		$(CC) $(FLAGS) $(OFLAGS) $(BINOFLAGS) $(CFLAGS) -c $< -o $@
