class LastRegion(object):
    """
    A region of a last-split
    """
    def __init__(self, name, start, end, strand, seq_len):
        self.name = name
        self.start = start
        self.end = end
        self.strand = strand
        self.slen = seq_len
                    
    def __repr__(self):
        return "\t".join([self.name, str(self.slen), str(self.start), str(self.end), self.strand])


class LastSegment(object):
    """
    a single alignment segment from last-split
    """
    def __init__ (self, segment_string=""):
        self.parse_string_fields(segment_string)

    def parse_string_fields(self, string):
        fields = string.split("\t")
        assert len(fields) == 13, "Expected 13 fields, found {}".format(len(fields))
        self.score = int(fields[0])
        self.hit = LastRegion(fields[1], int(fields[2]), int(fields[2]) + int(fields[3]), fields[4], int(fields[5]))
        self.query = LastRegion(fields[6], int(fields[7]), int(fields[7]) + int(fields[8]), fields[9], int(fields[10]))

    def __repr__(self):
        return "{}\t{}\t{}".format(self.query, self.hit, self.score)


def normalize_splits(splits):
    """
    Normalize coordinates so that the query runs on the positive strand
    """
    for split in splits:
        query = split.query
        hit = split.hit
        if query.strand == '-':
            query.strand = '+'
            query.start, query.end = query.slen - query.end, query.slen - query.start
            hit.strand = "-" if hit.strand == "+" else "+"


def parse_last_output(string):
    """
    parse tab-delimitted output from last-split
    """
    for line in string:
        if not line.startswith("#"):
            yield LastSegment(line)


with open(snakemake.input[0], "r") as infile:
    splits = []
    for line in infile:
        line = line.strip()
        if len(line) > 0 and line[0] != "#":
            splits.append(LastSegment(line.strip()))

normalize_splits(splits)
splits.sort(key=lambda x: (x.query.name, x.query.start)) 

query_fields = "\t".join(["query_id", "query_len", "query_start", "query_end", "query_strand"])
hit_fields = "\t".join(["hit_id", "hit_len", "hit_start", "hit_end", "hit_strand"])
header = "# " + "\t".join([query_fields, hit_fields, "segment_score"])


with open(snakemake.output[0], "w") as outfile:
    print(header, file=outfile)
    print("\n".join([str(s) for s in splits]), file=outfile)
