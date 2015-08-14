BASE = http://cancelthesefunerals.com

# note that .txt suffix is included is applicable
TEXTS = monthly/ma130101.txt \
	monthly/ma130201.txt \
	monthly/ma130301.txt \
	monthly/ma130401.txt \
	monthly/ma130501.txt \
	monthly/ma130601.txt \
	monthly/ma130701.txt \
	monthly/ma130801.txt \
	monthly/ma130901.txt \
	monthly/ma131001.txt \
	monthly/ma131101.txt \
	monthly/ma131201.txt \
	monthly/ma140101.txt \
	monthly/ma140201.txt \
	monthly/ma140301.txt \
	20111130/ssdm2 \
	20111130/ssdm3

# note that .zip suffix is omitted
ZIPS = 20130531/ssdm1 \
	20130531/ssdm2 \
	20130531/ssdm3

FOLDERS = monthly \
	20111130 \
	20130531

LOAD_TASKS = $(addprefix LOAD_,$(TEXTS) $(ZIPS))

.PHONY: index $(LOAD_TASKS)

index: deaths.db 2_index_deaths.sql | $(LOAD_TASKS)
	sqlite3 $< < 2_index_deaths.sql

$(LOAD_TASKS): LOAD_%: deaths.db data/%.sql
	sqlite3 $< < $(word 2,$^)

deaths.db: 1_setup_deaths_db.sql
	sqlite3 $@ < $<

.SECONDARYEXPANSION:
data/%.sql: data/% | $($*D)
	perl ./txt2sql.pl < $< > $@

$(addprefix data/,$(TEXTS)): data/%: | $($*D)
	curl $(BASE)/$* > $@

$(addprefix data/,$(ZIPS)): data/%: | $($*D)
	curl $(BASE)/20111130/$*.zip | unzip -p > $@

$(addprefix data/,$(FOLDERS)) $(addprefix sql/,$(FOLDERS)):
	mkdir -p $@
