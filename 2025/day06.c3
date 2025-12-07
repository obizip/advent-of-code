import std::io, std::collections, std::math, std::sort;

const INPUT_PATH = "input/input06.txt";
// const INPUT_PATH = "input/input06-test.txt";

fn long? solve1(List{String} lines)
{
	long ans = 0;

	String[] operators = dedup_space(lines[lines.len()-1]).trim().tsplit(" ");

	long[1024] results;
	String[] first_nums = dedup_space(lines[0]).trim().tsplit(" ");
	foreach (i, num_str : first_nums) results[i] = num_str.to_long()!;

	for (int i_line = 1; i_line < lines.len()-1; i_line++)
	{
		String line = lines[i_line];
		String[] num_strs = dedup_space(line).trim().tsplit(" ");
		foreach (i, num_str : num_strs)
		{
			switch (operators[i])
			{
				case "+":
					results[i] += num_str.to_long()!;
				case "*":
					results[i] *= num_str.to_long()!;
			}
		}
	}
	for (int i = 0; i < operators.len; i++) ans += results[i];
	return ans;
}

struct Range {
	long start;
	long end;
}

fn long? solve2(List{String} lines)
{
	long ans = 0;
	List{Range} ranges;
	String op_line = lines[lines.len()-1];
	long start, end;
	start = 0;
	for (int i = 0; i < op_line.len; i++) {
		if (i + 1 >= op_line.len)
		{
			end = (long)i;
			ranges.push({start, end});
		}
		else if (!op_line[i+1].is_space())
		{
			end = (long)i - 1;
			ranges.push({start, end});
			start = (long)i + 1;
		}
	}

	String[] ops = dedup_space(op_line).trim().tsplit(" ");
	foreach (i_range, range : ranges)
	{
		DString[1024] num_strs;
		for (int i_line = 0; i_line < lines.len() - 1; i_line++)
		{
			String line = lines[i_line];
			for (long i = range.start; i <= range.end; i++)
			{
				char c = line[i];
				if (!c.is_space()) num_strs[i - range.start].append(c);
			}
		}

		long res = 0;
		switch (ops[i_range])
		{
			case "+":
				res = 0;
				foreach (num_str : num_strs[0..range.end-range.start])
				{
					res += num_str.str_view().to_long()!;
				}
			case "*":
				res = 1;
				foreach (num_str : num_strs[0..range.end-range.start])
				{
					res *= num_str.str_view().to_long()!;
				}
		}
		ans += res;
	}
	return ans;
}

alias Numbers = List{long};

fn String dedup_space(String str) {
	DString processed = dstring::temp();
	bool prev_is_space = false;
	for (int i = 0; i < str.len; i++)
	{
		char c = str[i];
		if (c.is_space()) {
			if (!prev_is_space) processed.append_char(c);
			prev_is_space = true;
		}
		else
		{
			processed.append_char(c);
			prev_is_space = false;
		}
	}
	return processed.str_view();
}

fn void main()
{
	@pool()
	{
		File f = file::open(INPUT_PATH, "rb")!!;
		defer (void)f.close();

		List{String} lines;
		while (try line = io::treadline(&f)) lines.push(line);

		io::printfn("Q1: %d", solve1(lines)!!);
		io::printfn("Q2: %d", solve2(lines)!!);
	};
}
