import std::io, std::io::file, std::collections::list, std::collections::map, std::collections::set;

alias Pages = List{String};
alias Rule = HashMap{String, HashSet{String}};

fn int? solve1(Rule rule, List{Pages} lines)
{
	int ans = 0;
	foreach (pages : lines) {
		bool valid = true;
		for (int i = (int)pages.len()-2; i >= 0; i--) {
			String before = pages.get((usz)i);
			for (int j = i + 1; j < (int)pages.len(); j++) {
				String after = pages.get((usz)j);
				if (!rule.has_key(after)) {
					continue;
				}
				HashSet{String} afters = rule.get(after)!!;
				if (afters.contains(before)) {
					valid = false;
					break;
				}
			}
		}
		if (valid) {
			// io::printfn("%s %s", pages.len(), pages);
			ans += pages[pages.len()/2].to_int()!;
		}
	}
	return ans;
}

fn int? solve2(Rule rule, List{Pages} lines)
{
	int ans = 0;
	foreach (pages : lines) {
		bool valid = true;
		for (int i = 0; i < pages.len() - 1; i++)
		{
			String before = pages.get((usz)i);
			for (int j = i + 1; j < (int)pages.len(); j++) {
				String after = pages.get((usz)j);
				if (!rule.has_key(after)) {
					continue;
				}
				HashSet{String} afters = rule.get(after)!!;
				if (afters.contains(before)) {
					valid = false;
					String tmp = pages.get((usz)i);
					pages.set_at(i, pages.get((usz)j));
					pages.set_at(j, tmp);
					i = -1;
					break;
				}
			}
		}
		if (!valid) {
			// io::printfn("%s %s", pages.len(), pages);
			ans += pages[pages.len()/2].to_int()!;
		}
	}
	return ans;
}


fn void main()
{
	@pool()
	{
		// File f = file::open("input/input05-test.txt", "rb")!!;
		File f = file::open("input/input05.txt", "rb")!!;
		defer (void)f.close();

		List{Pages} lines;
		Rule rule;
		bool is_rule = true;
		while (try line = io::treadline(&f)) {
			// io::printfn("%s", line);
			if (line == "") {
				is_rule = false;
				continue;
			}
			if (is_rule) {
				String[] nums = line.tsplit("|");
				// io::printfn("%s %s", nums[0], nums[1]);
				HashSet{String} empty;
				HashSet{String} entry = rule.get(nums[0]) ?? empty;
				entry.add(nums[1]);
				rule.set(nums[0], entry);
			} else {
				String[] raws = line.tsplit(",");
				Pages pages;
				foreach (raw : raws) {
					pages.push(raw);
				}
				lines.push(pages);
			}
		}
		// io::printfn("%s", rule);


		io::printfn("Q1: %d", solve1(rule, lines)!!);
		io::printfn("Q2: %d", solve2(rule, lines)!!);
	};
}
