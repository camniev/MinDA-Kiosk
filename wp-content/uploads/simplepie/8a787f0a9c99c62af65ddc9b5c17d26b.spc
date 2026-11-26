a:6:{s:5:"child";a:1:{s:0:"";a:1:{s:3:"rss";a:1:{i:0;a:6:{s:4:"data";s:3:"


";s:7:"attribs";a:1:{s:0:"";a:1:{s:7:"version";s:3:"2.0";}}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:0:"";a:1:{s:7:"channel";a:1:{i:0;a:6:{s:4:"data";s:112:"
	
	
	
	







































































































";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:1:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:16:"WordPress Planet";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:28:"http://planet.wordpress.org/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:8:"language";a:1:{i:0;a:5:{s:4:"data";s:2:"en";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:47:"WordPress Planet - http://planet.wordpress.org/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"item";a:50:{i:0;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:82:"OpenStation Blog: I Deleted 168,000 Lines of Comments. My AI Agent Didn’t Notice";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"https://openstation.blog/?p=1474";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:96:"https://openstation.blog/2026/10/13/i-deleted-168000-lines-of-comments-my-ai-agent-didnt-notice/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:7714:"<p class="wp-block-paragraph">Almost a third of our source code was comments. I deleted all of them and asked an AI agent to build the same features on both versions of the codebase, three times each. The code it wrote was just as good with or without comments.</p>



<p class="wp-block-paragraph">If you use agents on a real codebase and wonder whether comments help them, slow them down, or don&#8217;t matter, here&#8217;s what I found.</p>



<h2 class="wp-block-heading">Why I tried this</h2>



<p class="wp-block-paragraph">In <a href="https://x.com/poteto/status/2102050467505430555">this video</a> (around 23:07), <a href="https://x.com/poteto">Lauren</a> mentions that they don&#8217;t let their agents write comments in the code. <a href="https://github.com/wordPress/openstation">Our codebase</a>, is the opposite: it&#8217;s full of comments, and most of them were written by agents.</p>



<p class="wp-block-paragraph">So I wondered: are all those comments helping the agent, or are they just extra text it has to read?</p>



<h2 class="wp-block-heading">The experiment in one paragraph</h2>



<p class="wp-block-paragraph">I made a copy of the codebase with every comment removed, about 168,000 lines in total. Then I gave the same task to the same agent on both copies, three times on each, and checked the results the same way. I did this for two tasks, a small one and a bigger one.</p>



<h2 class="wp-block-heading">The results</h2>



<p class="wp-block-paragraph">Every run passed every check: lint, type checks and the existing tests, plus, on the bigger task, a hidden test the agent never saw. A separate AI judge scored each result without knowing which copy it came from (more on that below).</p>



<p class="wp-block-paragraph"><strong>Small task: tile all open windows</strong> (score out of 19)</p>



<figure class="wp-block-table"><table class="has-fixed-layout"><thead><tr><th>Branch</th><th>Score</th><th>Tokens</th><th>Cost</th></tr></thead><tbody><tr><td>With comments</td><td>18.3</td><td>2.18M</td><td>$1.42</td></tr><tr><td>Without</td><td>19.0</td><td>1.71M</td><td>$1.04</td></tr></tbody></table></figure>



<p class="wp-block-paragraph"><strong>Bigger task: keep a window on top</strong> (score out of 23)</p>



<figure class="wp-block-table"><table class="has-fixed-layout"><thead><tr><th>Branch</th><th>Score</th><th>Tokens</th><th>Cost</th></tr></thead><tbody><tr><td>With comments</td><td>21.7</td><td>9.06M</td><td>$3.84</td></tr><tr><td>Without</td><td>22.0</td><td>9.12M</td><td>$3.95</td></tr></tbody></table></figure>



<p class="wp-block-paragraph">The numbers are averages of three runs. The score differences are within noise, and so is the cost on the bigger task. On the small task, the agent used about 22% fewer tokens without comments, which makes sense: there was simply less to read.</p>



<p class="wp-block-paragraph">The bigger task had a trap. The pinned state has to survive a page reload, and the PHP function that saves the window session drops any key it doesn&#8217;t know. Miss it and the feature looks fine until you reload. That&#8217;s exactly the kind of thing you&#8217;d expect a comment to help with. All six runs found it, with and without comments.</p>



<h2 class="wp-block-heading">Why one run is not enough</h2>



<p class="wp-block-paragraph">My first plan was to run each branch once. I&#8217;m glad I didn&#8217;t.</p>



<p class="wp-block-paragraph">On the bigger task, the three runs with comments used 8.21M, 8.79M and 10.17M tokens. The three runs without comments used 7.01M, 9.70M and 10.64M.</p>



<p class="wp-block-paragraph">If I had picked one run from each branch, I could have written two opposite blog posts. Comparing 10.64M with 8.21M, removing comments makes the agent 30% more expensive. Comparing 7.01M with 10.17M, it makes the agent 31% cheaper. Same task, same code, same day.</p>



<p class="wp-block-paragraph">Agents are not deterministic. If you&#8217;re measuring one, run it more than once.</p>



<h2 class="wp-block-heading">How I ran it</h2>



<ul class="wp-block-list">
<li><strong>The agent:</strong> Claude Code with Opus 5.5 at high effort. Same model and settings for every run.</li>



<li><strong>The two codebases:</strong> our main branch, and a copy with the comments removed. I compiled both and checked that the resulting code is identical. The only comments left are the ones the tools need to work, such as lint directives and plugin headers, about 800 lines.</li>



<li><strong>The tasks:</strong> two real features, with the same prompt on both branches.</li>



<li><strong>The checks:</strong> the project&#8217;s own lint, type checks and tests. On the bigger task, also a hidden test I added after the agent finished, so it couldn&#8217;t write code just to pass it.</li>



<li><strong>The judge:</strong> a separate Claude session read each change and scored it against a checklist written before the runs: does it work, does it follow the project&#8217;s conventions, does it have tests, and so on. The changes were labelled with random names, so the judge didn&#8217;t know which branch each one came from.</li>



<li><strong>The runs:</strong> three per branch per task, alternating branches so that time of day affected both equally.</li>
</ul>



<h2 class="wp-block-heading">My conclusion</h2>



<p class="wp-block-paragraph">For the agent, code comments don&#8217;t make a difference to the quality of the code it writes. They don&#8217;t help, and they don&#8217;t hurt.</p>



<p class="wp-block-paragraph">So keep a comment or delete it based on what it does for the people reading the code, not for the agent.</p>



<p class="wp-block-paragraph">This doesn&#8217;t prove comments have zero effect. I tested one model, two tasks and three runs per branch, which is enough to rule out a big effect, not a small one.</p>



<p class="wp-block-paragraph"><strong>Next:</strong> comments made no difference, but removing our <code>docs/</code> folder and AGENTS.md did. That&#8217;s the next post.</p>



<h2 class="wp-block-heading">Appendix: data and links</h2>



<ul class="wp-block-list">
<li>The <a href="https://github.com/WordPress/openstation/tree/28038e9f9d99b74b8b279a858c4ff8826b8ec48d">codebase with comments</a></li>



<li>The <a href="https://github.com/WordPress/openstation/tree/09f2b460203196654cbd930835cd70856bb52443">codebase without comments</a></li>



<li><a href="https://github.com/WordPress/openstation/compare/28038e9f...09f2b460">Exactly what was removed</a> (GitHub may only show part of it)</li>



<li>Two of the small-task runs as pull requests: <a href="https://github.com/WordPress/openstation/pull/974">with comments, PR 974</a> and <a href="https://github.com/WordPress/openstation/pull/975">without comments, PR 975</a></li>



<li>Full results, all runs: <a href="https://claude.ai/artifact/YUTg68tcXcf6XCo94g1Uhs">results page</a></li>



<li>If you want to see the experiment script and the rubrics, <a href="https://epeicher.github.io/wairehouse/openstation/experiments/comments-ab.html">they are all here</a></li>



<li>Lines of code, measured with <code>scc</code>:</li>
</ul>



<figure class="wp-block-table"><table class="has-fixed-layout"><thead><tr><th></th><th>With</th><th>Without</th></tr></thead><tbody><tr><td>Whole repository</td><td>765,491</td><td>597,332</td></tr><tr><td>Plugin source code</td><td>408,527</td><td>280,421</td></tr></tbody></table><figcaption class="wp-element-caption"><sub>Plugin source code means the code that ships in the plugin (src/, includes/, apps/ and the CSS), without tests, docs, or tooling.</sub>st</figcaption></figure>



<p class="wp-block-paragraph"></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 13 Oct 2026 17:58:37 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Roberto Aranda";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:1;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:27:"Matt: Neal Stephenson Live!";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:23:"https://ma.tt/?p=155205";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:43:"https://ma.tt/2026/10/neal-stephenson-live/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1718:"<p class="wp-block-paragraph">Speaking of sci-fi authors, <a href="https://automattic.com/">Automattic</a> is hosting Neal Stephenson for a livestream about <a href="https://amzn.to/47jviKj">his new book soon</a>, please tune in!</p>



<figure class="wp-block-embed alignwide is-type-video is-provider-youtube wp-block-embed-youtube wp-embed-aspect-16-9 wp-has-aspect-ratio"><div class="wp-block-embed__wrapper">

</div></figure>



<p class="wp-block-paragraph">Neal was a big influence on WordPress! I got hip to him from <a href="https://tantek.com/">Tantek</a>. In the source code of billions of pages you&#8217;ll see this:</p>



<pre class="wp-block-code"><code>&lt;link rel="profile" href="https://gmpg.org/xfn/11"></code></pre>



<p class="wp-block-paragraph">GMPG is the <a href="https://en.wikipedia.org/wiki/Global_Multimedia_Protocols_Group">Global Media Protocols Group</a>, &#8220;an <a href="https://gmpg.org/">experiment in Metamemetics</a>.&#8221; Inspired, of course, by the Global Multimedia Protocol Group that owned the virtual real estate in <a href="https://en.wikipedia.org/wiki/Snow_Crash">Snow Crash&#8217;s metaverse</a>.</p>



<p class="wp-block-paragraph"><a href="https://meyerweb.com/">Eric</a>, Tantek, and I were reacting to the idea that there should be a separate heavily-marked-up RDF or XML web, and that HTML couldn&#8217;t be extended or enriched with metadata in a way that was beautiful to both humans and machines. It was really an aesthetic war. (It later got more built out in <a href="https://microformats.org/">Microformats</a>.)</p>



<p class="wp-block-paragraph">We should revisit some of those principles because the web could use more distribution right now.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 13 Oct 2026 15:53:19 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Matt";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:2;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:99:"Open Channels FM: Balancing AI Efficiency Costs and Value in Markdown Data and Open Source Security";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2563520";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:106:"https://openchannels.fm/balancing-ai-efficiency-costs-and-value-in-markdown-data-and-open-source-security/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:150:"In today's news, markdown streamlines AI input, AI-generated security reports increase workloads, and autonomous agent costs affect project efficiency";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 13 Oct 2026 14:15:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"Bob Dunn";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:3;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:75:"Open Channels FM: Open Channels FM Heading to the Web Summit 2026 in Lisboa";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2563477";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:82:"https://openchannels.fm/open-channels-fm-heading-to-the-web-summit-2026-in-lisboa/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:330:"Next month in November, I&#8217;ll (Bob) be attending the Web Summit in Lisbon, Portugal. I have been to conferences in the past that have had attendance up to 15,000, but never one that has over 70,000 attendees. That&#8217;s a lot of people. A few months ago I applied for media creditation, unsure of their parameters [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 13 Oct 2026 10:00:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"Bob Dunn";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:4;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:17:"Matt: Board Agent";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:23:"https://ma.tt/?p=155203";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:34:"https://ma.tt/2026/10/board-agent/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1830:"<p class="wp-block-paragraph"><a href="https://automattic.com/">Automattic</a> is always 5–15 years ahead of other companies, but things happen faster now. I predict other companies will start scrambling to add great writers to their boards, because, well, look at the headlines in AI. <a href="https://ir.united.com/corporate-governance/board-of-directors">United&#8217;s board already has Walter Isaacson</a>. Authors are awesome, akin to founders in the startup/tech ecosystem.</p>



<p class="wp-block-paragraph">Public offer to all the great sci-fi/etc writers out there who I&#8217;m a huge fan of (<a href="https://kenliu.name/">Ken Liu</a>, <a href="https://www.nealstephenson.com/">Neal Stephenson</a>, <a href="https://en.wikipedia.org/wiki/Ted_Chiang">Ted Chiang</a>, <a href="https://andyweirauthor.com/">Andy Weir</a>, <a href="https://www.rameznaam.com/">Ramez Naam</a>, <a href="https://en.wikipedia.org/wiki/Kim_Stanley_Robinson">Kim Stanley Robinson</a>&#8230;) but not as close to as <a href="https://hughhowey.com/">Hugh</a> (I was part of him meeting his wife, officiated one of their weddings), I offer my services as your Board Agent to negotiate compensation and contracts for you! 1% fee, donated to the <a href="https://wordpressfoundation.org/">WordPress Foundation</a> or <a href="https://locusmag.com/">Locus Magazine</a>. I&#8217;ve become a bit of an expert in board protections, dynamics, compensation, and such. <img alt="🙂" class="wp-smiley" src="https://s.w.org/images/core/emoji/17.0.2/72x72/1f642.png" style="height: 1em;" /></p>



<p class="wp-block-paragraph"><em>Aside:</em> If you haven&#8217;t seen the <a href="https://en.wikipedia.org/wiki/Turn_Every_Page">Robert Caro / Robert Gottlieb documentary Turn Every Page</a>, run, don&#8217;t walk to your nearest streaming service!</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 13 Oct 2026 09:10:59 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Matt";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:5;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:63:"OpenStation Blog: What WordPress would have looked like in 1995";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"https://openstation.blog/?p=1457";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:82:"https://openstation.blog/2026/10/12/what-wordpress-would-have-looked-like-in-1995/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3391:"<p class="wp-block-paragraph">I&#8217;ve been wondering how far a theme can take <a href="https://wordpress.org/plugins/desktop-mode/">OpenStation</a>. Not just a wallpaper and a different color, but everything: windows, dock, menus, fonts, icons, layouts, etc. So I tried to make wp-admin look like two operating systems from a long time ago.</p>



<figure class="wp-block-image size-full"><img alt="The same wp-admin desktop, with the same windows open, switching between a 1995 look (teal desk, grey windows, a taskbar) and a 1984 look in black and white." class="wp-image-1454" height="750" src="https://i0.wp.com/openstation.blog/wp-content/uploads/2026/10/openstation-retro-95-to-84.gif?resize=1200%2C750&#038;ssl=1" width="1200" /><figcaption class="wp-element-caption">Can you believe that this is still WordPress? Turns out that the web is still fun! You only need WordPress, OpenStation, and one of these two themes.</figcaption></figure>



<p class="wp-block-paragraph"><a href="https://github.com/mmtr/wp-os-retro-95"><strong>Retro 95</strong></a> reimagines wp-admin as Windows 95. It even comes with a Start menu! And the classic clock sitting in the bottom-right corner is also there. You can <a href="https://wp-os-retro-95.space.fast/">try it live</a>.</p>



<figure class="wp-block-image size-full"><img alt="wp-admin with the Retro 95 theme: opening Posts from the Start menu and writing a new post titled Hello from 1995." class="wp-image-1455" height="540" src="https://i0.wp.com/openstation.blog/wp-content/uploads/2026/10/openstation-retro-95.gif?resize=960%2C540&#038;ssl=1" width="960" /></figure>



<p class="wp-block-paragraph"><a href="https://github.com/mmtr/wp-os-retro-84"><strong>Retro 84</strong></a> is the counterpart for Apple fans. It turns wp-admin into the first graphical OS that many people ever saw: the original Macintosh&#8217;s System 1. The beloved monochrome display, the classic pixelated font, and more! Check out the <a href="https://wp-os-retro-84.space.fast/">live demo</a>. </p>



<figure class="wp-block-image size-full"><img alt="wp-admin with the Retro 84 theme in black and white: previewing documents on the desk and writing a new post titled Hello from 1984." class="wp-image-1456" height="540" src="https://i0.wp.com/openstation.blog/wp-content/uploads/2026/10/openstation-retro-84.gif?resize=960%2C540&#038;ssl=1" width="960" /></figure>



<p class="wp-block-paragraph">And here&#8217;s a fun fact: every icon is pixel art typed into a text file, one character per pixel. The fonts were also made the same way, letter by letter.</p>



<figure class="wp-block-image size-large"><img alt="For each theme, a text file where every character is one pixel, the icon it becomes (a 1995 computer and a 1984 floppy disk), and the rest of the theme's icons." class="wp-image-1462" height="717" src="https://i0.wp.com/openstation.blog/wp-content/uploads/2026/10/openstation-retro-icons-as-text.png?resize=1024%2C717&#038;ssl=1" width="1024" /></figure>



<p class="wp-block-paragraph">Underneath, it&#8217;s the same wp-admin as always, just a few decades older.</p>



<p class="wp-block-paragraph">If you want to build your own theme, <a href="https://github.com/WordPress/openstation/blob/trunk/docs/desktop-themes.md">the docs</a> list everything a theme can change. Maybe it&#8217;s time for a proper Windows Vista comeback.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 12 Oct 2026 11:31:07 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Miguel Torres";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:6;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:76:"Open Channels FM: Building Stability Through Diversification in Tech Careers";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2563193";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:83:"https://openchannels.fm/building-stability-through-diversification-in-tech-careers/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:221:"In a fast-evolving tech industry, professionals are embracing diversification for stability and growth. This strategy fosters financial security, creativity, and adaptability, preparing individuals for unforeseen changes.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 12 Oct 2026 09:18:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:16:"Open Channels FM";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:7;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:91:"Open Channels FM: OCN Week in Review #5: Scale, Adaptation, Verification and Infrastructure";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2563443";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:94:"https://openchannels.fm/ocn-week-in-review-5-scale-adaptation-verification-and-infrastructure/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:287:"This week on Open Channels News, discover how AI is changing hardware, security reports, and gaming, plus the latest WordPress and enterprise data updates. Explore our concise wrap-up of major open source and tech stories, along with the recurring themes shaping the industry’s future.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 09 Oct 2026 13:00:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:16:"Open Channels FM";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:8;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:78:"Open Channels FM: Why Learning from Younger Colleagues Keeps You Fresh in Tech";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2562359";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:85:"https://openchannels.fm/why-learning-from-younger-colleagues-keeps-you-fresh-in-tech/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:210:"To thrive in the evolving tech industry, professionals should engage with younger colleagues, embracing their fresh perspectives to foster adaptability, resilience, and ongoing personal and professional growth.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 08 Oct 2026 14:06:27 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:16:"Open Channels FM";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:9;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:93:"Open Channels FM: How Open Channels FM Balances Human Content with the AI Transparency Report";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2563412";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:100:"https://openchannels.fm/how-open-channels-fm-balances-human-content-with-the-ai-transparency-report/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:101:"Learn how Bob Dunn chose to create a AI Transparency Report for the Open Channels FM Podcast Network.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 08 Oct 2026 12:00:34 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"Bob Dunn";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:10;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:87:"Open Channels FM: Meta Opens Muse to DIY Hardware, GPT-6 Plays WoW Blind, and BootLoops";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2563398";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:92:"https://openchannels.fm/meta-opens-muse-to-diy-hardware-gpt-6-plays-wow-blind-and-bootloops/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:204:"Open Channels News host Robert shares AI's evolving role, highlighting Meta's Home Link for hardware integration, GPT-6 Astra's gameplay without visuals, and BootLoops enhancing scientific research tools.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 07 Oct 2026 15:00:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"Bob Dunn";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:11;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:67:"WPTavern: #236 – Brian Coords on WordPress as the Source of Truth";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:48:"https://wptavern.com/?post_type=podcast&p=208932";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:81:"https://wptavern.com/podcast/236-brian-coords-on-wordpress-as-the-source-of-truth";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:57954:"<details>Transcript<div>
<p class="wp-block-paragraph">[00:00:19] <strong>Nathan Wrigley:</strong> Welcome to the Jukebox Podcast from WP Tavern. My name is Nathan Wrigley.</p>



<p class="wp-block-paragraph">Jukebox is a podcast which is dedicated to all things WordPress. The people, the events, the plugins, the blocks, the themes, and in this case, making WordPress the source of truth across web projects, not just the website.</p>



<p class="wp-block-paragraph">If you&#8217;d like to subscribe to the podcast, you can do that by searching for WP Tavern in your podcast player of choice, or by going to wptavern.com/feed/podcast, and you can copy that URL into most podcast players.</p>



<p class="wp-block-paragraph">If you have a topic that you&#8217;d like us to feature on the podcast, I&#8217;m keen to hear from you and hopefully get you, or your idea, featured on the show. Head to wptavern.com/contact/jukebox and use the form there.</p>



<p class="wp-block-paragraph">So on the podcast today we have Brian Coords. Brian&#8217;s journey started in teaching and after a surprise detour, thanks to a growing family and a need for new work, he jumped headfirst into WordPress, spending a decade in agency and freelance roles before landing as a developer advocate at WooCommerce. He&#8217;s known for his knack for explaining the complicated parts of WordPress, championing documentation, blogging, podcasting, and bridging the gap between community needs and product development.</p>



<p class="wp-block-paragraph">Brian recently delivered a talk at WordCamp US entitled, The Site is the Source of Truth, Block Themes, AI and Agency Workflows, and that&#8217;s the focal point for our conversation.</p>



<p class="wp-block-paragraph">We start with Brian&#8217;s background in both education and development, and how he finds his DevRel role the perfect bridge between those worlds. We then get into the evolution of WordPress from its early days to the present, questioning just what it is that has given the platform such staying power, especially as agencies race to adopt shiny AI tools or static site builders, and are tempted to throw WordPress out with the bath water.</p>



<p class="wp-block-paragraph">Brian sees unique value in the WordPress ecosystem, especially for sites with longstanding content, integrations, and complex needs. And he makes the case for why the platform is built to last.</p>



<p class="wp-block-paragraph">We talk through the idea of the site as the source of truth, using WordPress, and increasingly block themes, not only as a publishing platform, but as the repository for all your design, content, and workflow guidelines. Instead of letting generative AI run wild, and potentially cause chaos, Brian outlines how agencies and product teams can centralise approved patterns, templates, and even content guidelines directly in the WordPress site, helping both AI and human users maintain brand and design consistency.</p>



<p class="wp-block-paragraph">We also unpack the state of block themes, why agency adoption is taking longer than expected? What&#8217;s coming soon for WooCommerce users, and how the move to block-based building is reducing plugin sprawl and making sites more resilient. And of course, we wrestle with the tight rope walk of what should go into WooCommerce Core, versus what is better left to the ecosystem, especially in a world where AI can spin up basic plugins in seconds.</p>



<p class="wp-block-paragraph">If you&#8217;re curious about how WordPress agencies can survive and thrive alongside AI, what the future holds for block themes, and how to build smarter, more sustainable workflows, this episode is for you.</p>



<p class="wp-block-paragraph">If you&#8217;re interested in finding out more, you can find all of the links in the show notes by heading to wptavern.com/podcast where you&#8217;ll find all the other episodes as well.</p>



<p class="wp-block-paragraph">And so without further delay, I bring you Brian Coords.</p>



<p class="wp-block-paragraph">I am joined on the podcast by Brian Coords. Hello, Brian.</p>



<p class="wp-block-paragraph">[00:04:05] <strong>Brian Coords:</strong> Thank you for having me.</p>



<p class="wp-block-paragraph">[00:04:05] <strong>Nathan Wrigley:</strong> Oh, you&#8217;re so welcome. Brian and I were supposed to record this podcast episode at WordCamp US, but, Jamie Marsland.</p>



<p class="wp-block-paragraph">[00:04:14] <strong>Brian Coords:</strong> He ruined it, yeah.</p>



<p class="wp-block-paragraph">[00:04:16] <strong>Nathan Wrigley:</strong> Yeah, we&#8217;re going to blame him. We had another engagement, which was to watch Jamie Marsland. But I appreciate you giving me the time after your WordCamp US experience. We&#8217;re both back home now.</p>



<p class="wp-block-paragraph">But if anybody isn&#8217;t familiar with you, Brian, we&#8217;re going to be talking a little bit about a presentation that you did at WordCamp US. That&#8217;s going to be the fulcrum around which the conversation goes. I&#8217;m going to encourage everybody, probably to go and look at the WP Tavern show notes, check them out. We will link to that presentation, which is called The Site is The Source of Truth: Block Themes, AI, and Agency Workflows.</p>



<p class="wp-block-paragraph">Hopefully gives you some intuition of what we&#8217;re going to talk about. Brian, do you just want to tell the audience a little bit about you? I know it&#8217;s a rather generic question, but tell us about you, your background, lo these many years.</p>



<p class="wp-block-paragraph">[00:04:58] <strong>Brian Coords:</strong> Yeah, so currently I work at WooCommerce as a developer advocate, so just working on community documentation, release posts, the blog, all that kind of communication stuff for WooCommerce.</p>



<p class="wp-block-paragraph">But before that, I spent like 10 years in the agency and freelancer world building WordPress sites, so I leaned on that for WordCamp US. Especially because you can only talk about WooCommerce so much at a WordCamp, so I leaned on my agency background and figured block themes, AI, all this stuff mixing around, what can I try to make sense out of it, and I don&#8217;t know if I did, but I got some thoughts out.</p>



<p class="wp-block-paragraph">[00:05:34] <strong>Nathan Wrigley:</strong> I remember a couple of years ago, prior to you getting that job, you were doing various bits and pieces, one of which actually for a tiny period of time was writing for The Tavern. And then I remember you getting the job. I was looking at your profile on social media, I think, and you landed the developer relations job, and I thought, &#8220;Oh, if ever there was a job which fitted a character,&#8221; it felt like you had dropped into something absolutely ideal. Do you just want to tell us what that role actually involves? And is it as ideal as it sounds for somebody of your characteristics?</p>



<p class="wp-block-paragraph">[00:06:03] <strong>Brian Coords:</strong> Yeah. To be honest, I saw that that was a type of job that existed in tech, and before I worked in any web development, I was a teacher. I was a high school teacher, so kind of wanted to bring back teaching and writing into what I did as a day job. So I saw that&#8217;s what a developer advocate, that&#8217;s like what DevRel does, and I basically spent like a year or two doing it for free, to prove that I could do it and get a job. And was like, &#8220;I&#8217;ll just pretend to be one, and then eventually somebody will pay me&#8221;,. And that&#8217;s kinda how it worked out.</p>



<p class="wp-block-paragraph">I mean that&#8217;s basically the job, is you&#8217;re teaching, you&#8217;re doing a lot of writing, you&#8217;re doing a lot of explaining things, you&#8217;re taking a lot of community feedback and bringing it back internally and saying, &#8220;This is what people are asking for, this is what they like or don&#8217;t like about the new feature&#8221;. You&#8217;re just bridging that communication gap, but you are also not responsible for any code, and that&#8217;s the best part of it. I&#8217;m less stressed about code overall.</p>



<p class="wp-block-paragraph">[00:06:57] <strong>Nathan Wrigley:</strong> I&#8217;m just going to go totally off piste here because I want to dig into what you said there, because I find that really interesting.</p>



<p class="wp-block-paragraph">One of the most important pillars of, I think, every society is the education piece, particularly of the younger generation, the children. I have reasons to be into that, but I won&#8217;t share them here. But, very, very meaningful to me.</p>



<p class="wp-block-paragraph">Do you miss that aspect of life? Obviously there&#8217;s a reason that you stepped away from that. Perhaps it was paperwork or burnout or whatever it may be. But do you miss the kind of face-to-face bit? Because obviously I&#8217;m imagining that you were, there was you, Brian, at the front talking to actual humans who you could reach out and touch if you needed to. How does this map to that, and the desire that you obviously once had to be an educator with real humans inside a real classroom?</p>



<p class="wp-block-paragraph">[00:07:39] <strong>Brian Coords:</strong> I left it sort of accidentally. We got pregnant with our first kid and needed to move, and I just needed to find a job closer to home. And it just was an accident, and I stumbled into WordPress and tech and everything. And so, I did miss it and I felt, I think I had an experience where I spoke at a WordCamp and I was like, it felt like teaching, because it was like I know everybody in the room. This is a community, I know everybody, I have a relationship with them. I&#8217;m up in front of the room talking to them, but they&#8217;re also yelling at me and heckling me because we know each other so well.</p>



<p class="wp-block-paragraph">So it reminded me of that vibe. So I kind of did look for this job as a way to bridge the two things, the WordPress and the tech side, and also a chance to do writing and teaching and bring it back a little bit. And maybe one day I&#8217;ll go back to a classroom or something.</p>



<p class="wp-block-paragraph">[00:08:27] <strong>Nathan Wrigley:</strong> Yeah, maybe. One of the curious things that I think about when you see education done well online, you watch somebody&#8217;s YouTube content or wherever that content may land. You sort of get the impression that they just turned on the camera and began. Oh, they&#8217;ve added in some animations, and they&#8217;ve cut and done transitions and things like that.</p>



<p class="wp-block-paragraph">But for every, let&#8217;s say 30 minutes that you produce online, is there, an hour, two hours, three hours of thinking it through, figuring out the pedagogy, who&#8217;s the audience, how do you write to their skill level? Just talk us through that bit a little bit, and I promise that&#8217;s the last off-piste bit we&#8217;ll do.</p>



<p class="wp-block-paragraph">[00:09:03] <strong>Brian Coords:</strong> Yeah, I mean, for everything that I record, I spend a lot of time doing drafts of it. I&#8217;ll try to write the whole thing and just, what would this look like if I wrote the whole thing out?</p>



<p class="wp-block-paragraph">And then, I&#8217;ve tried doing, a prompter where you read into the camera, and that never feels natural, it doesn&#8217;t work. But if I do three or four takes of it, by the time I get to that fourth take, I&#8217;ve internalized it, and then I can free flow it after that. And that&#8217;s how I approach my talk at WordCamp, where I just kept doing it personally, to the point where I felt like I could just say the stuff naturally.</p>



<p class="wp-block-paragraph">But I do bring in some of the teaching stuff of thinking about what is the student doing at the time? What are their goals? What is the one thing that they should walk away from this? And I try to bring as much of that into it, but, it&#8217;s hit or miss, you know.</p>



<p class="wp-block-paragraph">[00:09:49] <strong>Nathan Wrigley:</strong> Yeah, I guess one of the things that you always were going to miss is the sort of the feedback loop of having people in front of you, you know you&#8217;re, if all the children in front of you are gazing at the floor, then you know you&#8217;ve definitely pitched it incorrectly and you probably need to rethink. But you&#8217;re not necessarily going to get that shooting YouTube videos, but perhaps would, inside of a WordCamp. I can see you nodding, I hope that&#8217;s not actually what&#8217;s happened.</p>



<p class="wp-block-paragraph">[00:10:12] <strong>Brian Coords:</strong> Yeah, your YouTube comments are pretty close to being in front of a bunch of middle schoolers, right? That&#8217;s pretty similar. But the face-to-face and being in a real room is important. That&#8217;s why I took this job too, is more WordCamps, more Meetups, more time in person, but also I don&#8217;t have to leave my house every day.</p>



<p class="wp-block-paragraph">[00:10:29] <strong>Nathan Wrigley:</strong> Yeah, there is that.</p>



<p class="wp-block-paragraph">[00:10:30] <strong>Brian Coords:</strong> I get a balance.</p>



<p class="wp-block-paragraph">[00:10:30] <strong>Nathan Wrigley:</strong> That&#8217;s really nice, isn&#8217;t it? Yeah, so you can be working at the time of day that suits you and your family.</p>



<p class="wp-block-paragraph">Okay, so back on the piste. The title of the presentation, as I said, is The Site is the Source of Truth, Block Themes, AI, and Agency Workflows. I&#8217;m just going to read some of the blurb just so that the listener has context, and it goes like this.</p>



<p class="wp-block-paragraph">&#8220;Block themes give WordPress an opportunity to become more than a publishing tool or a place where finished designs are implemented. With the right theme structure, patterns, templates, and brand guidelines, a WordPress site can become the source of truth for how new pages and layouts should be built. That matters even more as agencies begin using AI in their build process. AI is useful when it can work from existing pieces, approved patterns, real content, design tokens, reusable blocks, and known template structures. It is much less useful when it starts every landing page from scratch.&#8221;</p>



<p class="wp-block-paragraph">And it goes on, but I&#8217;ll stop there. Do you want to just summarize what you actually did in that presentation? Then we&#8217;ll dig into the bits and the pieces.</p>



<p class="wp-block-paragraph">[00:11:27] <strong>Brian Coords:</strong> Yeah, so you submit the idea for a talk months before a conference, and then you get to the conference and three weeks ahead they tell you, &#8220;Hey, your talk got selected.&#8221; I submitted a couple. That was the one they picked, and then I read all that and I thought, &#8220;Did I write that?&#8221; I couldn&#8217;t even remember writing all that.</p>



<p class="wp-block-paragraph">But it, the timing actually worked out because we are doing a block theme in Woo right now, and I&#8217;m spending a lot of time focusing on that. It all lined up. But I definitely read that description, and I had already started working on some slides and I thought, &#8220;Oh, I don&#8217;t know how much this lines up to what I actually am presenting.&#8221;</p>



<p class="wp-block-paragraph">But I think the goal of what I wanted to do is talk about, I feel like a lot of agencies these days are saying, &#8220;We don&#8217;t need WordPress. We&#8217;re moving to static sites. We&#8217;re just letting AI vibe code everything on our sites.&#8221; And I wanted to kind of say there&#8217;s some value in the systems that WordPress has. It&#8217;s maybe a little more work, but there&#8217;s reasons for it.&#8221;</p>



<p class="wp-block-paragraph">And I ended up doing a history lesson of, &#8220;Here&#8217;s where WordPress started. Here&#8217;s where we took the journey of why things are the way they are, and the benefits for agencies.&#8221; and so I kind of ended up in a place where I got to that topic, but I did a lot of rambling throughout the presentation. I felt like the context was really important. The like, why are we here? Why is WordPress the way it is.</p>



<p class="wp-block-paragraph">[00:12:45] <strong>Nathan Wrigley:</strong> Yeah. Okay, that&#8217;s really interesting. So you said there, values in the systems that we have, and we&#8217;ll explore that in a moment. But technology&#8217;s such a weird one, isn&#8217;t it? In that most of the evolution of humans, we come up with ideas and then we finesse them a little bit. We adapt them over time, but it can be, a decade, 100 years before any major improvement takes place. You think the printing press, it just carried on as that printing press for many hundreds of years before it got slightly tweaked with linotype and things like that.</p>



<p class="wp-block-paragraph">But technology seems to be quite happy to wholesale throw the baby out with the bathwater on a more or less continuous cycle. So, why then do you feel that WordPress should buck that trend in the advent of AI? Like, why does it stand a chance when AI systems are becoming ultra-capable, static sites, or just talk to your agent and it&#8217;ll just build whatever you want. What is it? What&#8217;s the intrinsic value that you think will mean that it will be around in a, I don&#8217;t know, 5 years, 10 years, whatever that may be?</p>



<p class="wp-block-paragraph">[00:13:42] <strong>Brian Coords:</strong> Yeah, I think that&#8217;s a question everyone&#8217;s asking, which is, &#8220;Is there a unique value to WordPress that you can&#8217;t replace with AI?&#8221; And I think some people will point to the community and just the ecosystem and the fact that so many solutions already exist. I feel like AI is really good when you have nothing, and you&#8217;re going from zero to one. I have nothing and I&#8217;m going to make something brand new.</p>



<p class="wp-block-paragraph">Once you get to something where you&#8217;ve had a site for 10 years and it has tons of content and tons of authors and all these integrations and all these sorts of things, AI is helpful, but everything has to move a little slower, everything has to be a little bit more resilient, and those are the places where having a little framework underneath, something like WordPress holding everything together, ends up being a little bit more valuable. But it&#8217;s definitely changing when you would use it, when you would reach for it, and I think that&#8217;s the part people are struggling with right now.</p>



<p class="wp-block-paragraph">[00:14:30] <strong>Nathan Wrigley:</strong> Yeah. There&#8217;s so many examples in my life where there&#8217;s a new innovation, but I stick with the older thing, just because it&#8217;s tried and it&#8217;s tested, and I know the limitations of it and I know what I can do with it. So maybe that&#8217;s a good comparison.</p>



<p class="wp-block-paragraph">It will be interesting to see how AI is able to adapt and just simply build things which are robust and usable. But I think at the moment, the core promise for anybody trying to sell a website to a client, for example, is exactly that. It&#8217;s reliable. It&#8217;s battle tested. It&#8217;s been used on millions of sites all over the world, and it&#8217;s got a familiar interface and you can go in and do this, that, and the other thing, and click save and publish and what have you, and it&#8217;ll just work. Whether or not that remains the case a, a decade from now, I guess only time will tell.</p>



<p class="wp-block-paragraph">But, have this idea in your presentation of the site being the, and you said the, source of truth. What did you mean by that? What is the underpinning of that? What are the bits that kind of spin off if the WordPress site is the source of truth, what are the bits that sort of rely on that foundation?</p>



<p class="wp-block-paragraph">[00:15:28] <strong>Brian Coords:</strong> Yeah, I think one of the things that people see when they start using AI is it will just do whatever it wants. So you could ask it for two pages on your site, and they might look completely different. It might pull in some design trend here. The language might be completely different on this other one. It might not understand your audience and your values.</p>



<p class="wp-block-paragraph">And so with AI, you end up doing a lot of shepherding that&#8217;s kind of like, &#8220;well, no, this is the target audience. This is my color palette. This is the design things I like to use.&#8221; And so I leaned a lot in the talk to things like patterns in WordPress. Where, it&#8217;s something we do in WooCommerce where we have a designer, they&#8217;re very talented, they make really nice patterns that really conform to our brand. And then AI can go in and say, &#8220;pull the patterns down from the site first and use those. Don&#8217;t spin up crazy new designs. Use the ones that our human designer put a lot of care and effort into, that live in the pattern library on the website.&#8221;</p>



<p class="wp-block-paragraph">And so the more you put into the website and the more you train AI to, don&#8217;t go crazy and create new things, use the stuff I already have, use the tools I have, that I think makes things a little bit more reliable, a little bit more consistent. And so I think for agencies, finding ways to put stuff into the website that&#8217;s going to help the AI, and guide it directly to doing things the right way. Instead of it always wanting to like, come up with some brand-new chunk of code that you now have to look at. So that was kind of a part of it definitely.</p>



<p class="wp-block-paragraph">[00:16:52] <strong>Nathan Wrigley:</strong> So, what you&#8217;re saying there is instead of having all these disparate things like, I don&#8217;t know, you&#8217;ve got a Figma file over there. And you&#8217;ve got a Google document over here. And you&#8217;ve got another three different things and you can&#8217;t really figure out where the heck they are.</p>



<p class="wp-block-paragraph">Put it all in a WordPress website, and from the point of view of the design, patterns would fit beautifully for that. You can organise your typography, and basic colour palettes, and layouts, and the way things ought to look. And I don&#8217;t know, here&#8217;s two dozen ways that we might structure a page. Lock all of that away. You don&#8217;t necessarily have to publish it anywhere on the front end, but the AI can go and creep around in there and get some guidance.</p>



<p class="wp-block-paragraph">But then also presumably you could do the same with, I don&#8217;t know, your writing style. You could have draft posts where you outline the manner in which you would like to convey your company. And the words which are off limits, or the words which are definitely going to be used. So in that sense because WordPress can do video, it can do audio, it can do designs, it can do layouts and typography, why not just have that as the source of truth? Is that a sort of summation of what you were saying?</p>



<p class="wp-block-paragraph">[00:17:54] <strong>Brian Coords:</strong> Yeah, I think that&#8217;s essentially right. And I talked a little bit about, there&#8217;s a project in WordPress called Content Guidelines, I think, and it does that. Where you put in a lot of your rules. And then I also talked, a lot of agencies use GitHub and Git repos for their WordPress sites, and in there you can do things like having agents files, and skills and stuff that share across your team.</p>



<p class="wp-block-paragraph">So sometimes it&#8217;s in WordPress, sometimes it&#8217;s in that kind of GitHub code base for your website. So it depends on your agency&#8217;s workflows and stuff. But the point is, everybody puts stuff in the same place, because when I worked at an agency, it was that. It was, they used Figma and they used XD, and they have a Google Doc with all the technical specs, and then there&#8217;s 15 emails from the client. And AI actually is really good at taking all those things and putting it in one place and building a little knowledge base. And then when you bring on another developer, their AI is going to know exactly where that is, and it&#8217;s going to make things a little bit more scalable.</p>



<p class="wp-block-paragraph">So it&#8217;s just an organizational principle, like just cleaning things up, putting stuff in one space, and making WordPress sort of the home for that, instead of using all these different tools that maybe you don&#8217;t need, or maybe you&#8217;re going to lose access to.</p>



<p class="wp-block-paragraph">[00:19:00] <strong>Nathan Wrigley:</strong> I can&#8217;t remember the name, I think you just called it content guidelines or something like that. I can&#8217;t remember the name of that project, and I also can&#8217;t remember whether the intention is to ship that in Core at some point.</p>



<p class="wp-block-paragraph">That seems like a really curious idea. Presumably it&#8217;s a non-public facing repository of, I&#8217;m doing air quotes, &#8220;stuff&#8221;. So you just dump into there all of the different bits and pieces. Presumably by trial and error over many iterations, you&#8217;ll figure out exactly what the agent&#8217;s creeping around in your site, and that content guidelines portion of your site is going to be able to take from that.</p>



<p class="wp-block-paragraph">And you would amend it, and then when you begin another client site, that would be your first port of call. Get your client guidelines figured out, get that set of constraints worked out, and then move on with the design process.</p>



<p class="wp-block-paragraph">That&#8217;s a really neat idea. Somewhat hidden from the public, but pretty neat. Now, I don&#8217;t really deal with agencies. I don&#8217;t have any communication with them. Do you have a sense that they&#8217;re open to these ideas, or it&#8217;s just some sort of curiosity which the core team think they might ship, but who knows whether anybody will use it? Have you got intuitions that this would be used?</p>



<p class="wp-block-paragraph">[00:20:00] <strong>Brian Coords:</strong> Yeah, that&#8217;s been an interesting one. That content guidelines feature almost shipped, and then it got pulled at the last minute and was kind of like, &#8220;Let&#8217;s see some real world usage of this.&#8221; I think it&#8217;s probably really helpful for big news publications. That&#8217;s what I&#8217;ve heard a lot of. Where they have 20 authors and they want to make sure their authors are doing the right thing, and so that makes sense.</p>



<p class="wp-block-paragraph">I think for agencies, a lot of the ones I talk to, they really, they like putting things in GitHub. That&#8217;s where they like to put stuff, and they like putting it in the code. I don&#8217;t know if they&#8217;ll put it in WordPress, but I think it&#8217;ll be interesting to see. But I feel like we&#8217;re all just dealing with, there&#8217;s just tons of content, and markdown files, and prompts and skills and all these overwhelming amounts of things, and it&#8217;s like everybody together is trying to figure out what are the best ways to do this. And I think it&#8217;s just fun to explore the ideas and see. In two years maybe we&#8217;ll all have the answer to this.</p>



<p class="wp-block-paragraph">[00:20:54] <strong>Nathan Wrigley:</strong> Yeah. We&#8217;ll have a fresh set of new problems in two years.</p>



<p class="wp-block-paragraph">[00:20:57] <strong>Brian Coords:</strong> Yeah.</p>



<p class="wp-block-paragraph">[00:20:57] <strong>Nathan Wrigley:</strong> It was curious there, we&#8217;d been talking about AI for a while and then when you, corroborated your examples there, you described the humans using it, which I thought was quite interesting. So you&#8217;ve got these 20 people working for, let&#8217;s say, TechCrunch or something like that. Big organization, lots of editors, lots of authors and what have you. But even if the AI never touches base on that, just the idea that the humans can access it in a human-readable way, not all about the AI.</p>



<p class="wp-block-paragraph">Just that seems worth shipping. If all that you do is have some mechanism to show brand new author to techcrunch.com, how you would like things to look and feel and what have you, that seems like a reason to ship it even if the AI portion isn&#8217;t launched at the beginning.</p>



<p class="wp-block-paragraph">[00:21:38] <strong>Brian Coords:</strong> I think everybody&#8217;s explored, I know I did, where you go all in on AI and it&#8217;s going to write all my stuff, and it&#8217;s going to do all these things for me. And then internally we&#8217;ve had a, I forget what the post, but somebody wrote this kind of, writing is for humans post, and a lot of people in the company rallied around that. Which is like, it was fun to let AI do some stuff, but writing is important, and writing should be done by humans. We don&#8217;t want to put AI content out. So at the end of the day, we expect humans to write, and we still really value that, and writing is a valuable thing in and of itself.</p>



<p class="wp-block-paragraph">But then AI can come in a little later and say, &#8220;Well, maybe I&#8217;ll review it for you. Maybe I&#8217;ll give you some feedback and you can take it or not.&#8221; But it&#8217;s been an interesting, I feel like there was a pendulum where AI will do everything, and now it&#8217;s like, no, I think we&#8217;ll find the places for it to make things move faster, but there&#8217;s just still human value, and I&#8217;m glad to see that pendulum maybe coming back, at least internally for us it is.</p>



<p class="wp-block-paragraph">[00:22:34] <strong>Nathan Wrigley:</strong> Sorry, going slightly off piste here, but I have an intuition that by the time another decade has passed, I think there is a version of the universe in which people have become really sick and tired of AI. I think it&#8217;s a really plausible future that some things will be viewed with enormous incredulity and skepticism if there&#8217;s any hint of it being done by an AI.</p>



<p class="wp-block-paragraph">So perhaps that won&#8217;t be design. Perhaps it won&#8217;t be music. Perhaps it won&#8217;t be coding. But I&#8217;ve got a feeling that writing, especially fictional writing and things like that, but also opinion pieces and things, I think that is highly likely to become, once again, the domain of a human being. And I know for certain that my own children are very skeptical about AI and the future that&#8217;s presenting. So yeah, I welcome that commentary. I&#8217;ll leave it there if you&#8217;ve got anything to follow up with. If not, I&#8217;ll ask another question.</p>



<p class="wp-block-paragraph">[00:23:22] <strong>Brian Coords:</strong> Yeah, I go back and forth on it. I&#8217;ve never listened to AI music, and I don&#8217;t think I ever will.</p>



<p class="wp-block-paragraph">[00:23:28] <strong>Nathan Wrigley:</strong> No.</p>



<p class="wp-block-paragraph">[00:23:29] <strong>Brian Coords:</strong> Maybe I have and I just don&#8217;t know it.</p>



<p class="wp-block-paragraph">[00:23:31] <strong>Nathan Wrigley:</strong> Curiously, I bet you have. Yeah.</p>



<p class="wp-block-paragraph">[00:23:32] <strong>Brian Coords:</strong> Yeah, I probably have. AI writing is the same way. It&#8217;s if you can&#8217;t tell that it&#8217;s AI, will that matter? And I think at the end of the day it will, because I don&#8217;t read things unless I know who the author is and I&#8217;m interested in their perspective, and I don&#8217;t really listen to music if I don&#8217;t know, I like to know the story of the band, and I like to know the context. If I&#8217;m reading a book, I like to know when the author lived and what culture they&#8217;re filtering everything through and, yeah, maybe we&#8217;ll be unique and some people will just want to doom scroll AI videos of cats, but I never did that before, so I don&#8217;t know if I&#8217;ll do it starting now.</p>



<p class="wp-block-paragraph">[00:24:05] <strong>Nathan Wrigley:</strong> No, but curiously, it might offer a slight marketing edge, let&#8217;s put it that way. If you can certify provably that you are the real thing. Whether that be in the music space and you simply have to record the process of you going through the process of creating a song with all of the mistakes, and heartache, and anguish that that is.</p>



<p class="wp-block-paragraph">But I feel that maybe there will be a craving for that in the future. Maybe people will literally work harder to find people online who are provably writing their own material, be that songs or making videos or writing and what have you.</p>



<p class="wp-block-paragraph">So we&#8217;ve all been swamped AI and been beguiled by it, I think as you&#8217;ve said, the pendulum feels like there&#8217;s a bit of a swing in the other direction, and it might be that you can have a marketing edge simply because you&#8217;re actually taking the time to, to write things out. So anyway, there you go.</p>



<p class="wp-block-paragraph">Let&#8217;s move on slightly. So block themes. You were mentioning that at Woo you&#8217;re currently playing with a block theme. I don&#8217;t know how many of those are actually in the bag already and out there in the wild coming directly from Woo. But it does feel that many years ago block themes were being touted as the thing.</p>



<p class="wp-block-paragraph">It feels like it didn&#8217;t turn out quite the way we expected. There hasn&#8217;t been this deluge of block themes, and everybody&#8217;s put the classic themes behind them. I think people are clinging to classic themes for a variety of reasons. Do you want to just talk about why you think block themes fit into this whole agency source of truth piece as well?</p>



<p class="wp-block-paragraph">[00:25:28] <strong>Brian Coords:</strong> Yeah, block themes have been interesting. I&#8217;ve seen a lot of agencies that really start to like them, and agencies understand the value. I think, for a lot of existing websites, just changing your theme is hard. There has to be a really good reason to change your theme, because who knows what&#8217;s going to break? Who knows how everything is going to work, especially with e-commerce? It&#8217;s like if it&#8217;s not broken, don&#8217;t touch it. There better be a good reason for it.</p>



<p class="wp-block-paragraph">And so I think in some ways for a lot of people, block themes for existing sites maybe haven&#8217;t given them a really good reason to switch yet. But I think it will for a number of reasons. I was actually just talking to a coworker about our block theme that we&#8217;re getting ready to launch. Probably by the time this is out, it might be in a public beta.</p>



<p class="wp-block-paragraph">But one of the things that was interesting is in WooCommerce, there was a theme called Storefront, which was like, that was the WooCommerce theme. And we&#8217;re doing a comparison right now, where if you wanted to move from Storefront to our block theme, Storefront had all these plugins. A plugin to do a header on your site, and a plugin to do a little mini cart, and a plugin to do product carousels, and all these plugins you would have to install. And that meant testing them and making sure they work and updating.</p>



<p class="wp-block-paragraph">And we did a comparison of how many of these things can you already just do in the block editor, and it was like 90% of it already exists in the block editor. And you don&#8217;t need a plugin for it, and you don&#8217;t need extra code, and you don&#8217;t need to buy a new extension. So I think people are starting to see the value of it, once they realize how much is just included. I can change anything. I don&#8217;t need a plugin to add this or that to my site.</p>



<p class="wp-block-paragraph">So I think there&#8217;s a lot of value to it, and it just ends up being a little safer because it&#8217;s just WordPress and WooCommerce and a theme that only has a little bit of styling. I&#8217;m not worried about the compatibility of plugins, and I&#8217;m not worried about paying for updates and all these sorts of things, and is it going to break on the next version?</p>



<p class="wp-block-paragraph">And so I think there&#8217;s a lot of value to it, and it just makes WordPress itself more the thing you&#8217;re relying on. You&#8217;re just relying on the blocks. You&#8217;re just relying on the things that WordPress gives you. So I think there&#8217;s going to be a lot of benefits to it, but yeah, we have not, there is no WooCommerce official block theme yet, but we&#8217;re hoping that there will be one soon.</p>



<p class="wp-block-paragraph">[00:27:31] <strong>Nathan Wrigley:</strong> One of the things that I thought block themes would tackle really quickly soon after launching, which never kind of ended up being the case, was for example, things like WooCommerce, atomising every bit of a WooCommerce site into a separate, let&#8217;s say block. So for example, I don&#8217;t know, the add to cart block, and the the I don&#8217;t know, show the quantity in the cart in the menu block, and yada, yada.</p>



<p class="wp-block-paragraph">And you go to the cart page or the payment page, and you would just fill it up with the blocks as you&#8217;d like, and add spacing and add margins and what have you. That never seemed to take off, but also I don&#8217;t know if it&#8217;s still talked about, or the promise of that is still something that you are hoping to deliver.</p>



<p class="wp-block-paragraph">Just talk us through where we&#8217;re at in terms of atomising the entirety of a WooCommerce site into individual blocks. So rather than dropping entire sort of templates or structures, you can pick and cherry pick. obviously there&#8217;d be dependencies. If you&#8217;ve got this, you must have that. But just tell us where we&#8217;re at.</p>



<p class="wp-block-paragraph">[00:28:28] <strong>Brian Coords:</strong> Yeah, so overall you can do that for most of a store. I think the only thing that doesn&#8217;t have blocks right now at all is like the account pages. Somebody logs in and they see their downloads and their order history and all that. That stuff is, I don&#8217;t even think is anywhere blocks at all. But that was one of the things as part of this process is, we looked at all the blocks, because there is a add to cart button block, and there is a quantity selector block, and there is a product image gallery block. I mean there&#8217;s like a, more than 100, maybe 200 blocks in WooCommerce.</p>



<p class="wp-block-paragraph">There&#8217;s a lot, but the thing that they were missing was the style controls, which is I think what a lot of people wanted. Which is if I have the button, is it going to look like every other button on my site? And can I customize it? Are all the form inputs on my checkout page going to look just like the drop down on my product selection page?</p>



<p class="wp-block-paragraph">And so that&#8217;s been the big push recently, like actually building the block theme, like 90% of the work of what they&#8217;re doing is just fixing the blocks, and making the blocks better. And the theme is just a very thin layer.</p>



<p class="wp-block-paragraph">So it&#8217;s gotten a lot better, and that&#8217;s kind of the goal is once we have our own theme we can show, okay, all this stuff is customizable and editable. And I think probably in the next release you&#8217;ll see a huge focus on those block style changes showing up in WooCommerce.</p>



<p class="wp-block-paragraph">[00:29:44] <strong>Nathan Wrigley:</strong> I have a curious question that you may or may not wish to answer. Let&#8217;s see how this one goes. If you, as you just described, you were talking about you don&#8217;t need a plugin for that. You don&#8217;t need to worry about an update or a payment for this thing. We&#8217;re bringing all that functionality into Core.</p>



<p class="wp-block-paragraph">I&#8217;m wondering what that tightrope looks like, where over there somewhere, part of the community, somebody&#8217;s got a paid plugin, which is the basis of their entire livelihood. But it just so happens that, we could really ship that in Core, and that would be really useful to have in Core. We reckon that 80% of the people who use WooCommerce will use that.</p>



<p class="wp-block-paragraph">How do you decide when something gets made and the obvious sort of community impact that that thing may have had? So as I said, that&#8217;s a tricky question. I will leave you to answer it or not.</p>



<p class="wp-block-paragraph">[00:30:31] <strong>Brian Coords:</strong> Yeah, it is a huge topic of discussion. James Kemp, who is the Core product lead has been pushing for more of these things in Core. And I think that the big question right now is, are a lot of the people making money on plugins going to be able to continue making money on some of those plugins with AI? Because there&#8217;s a lot of plugins that are 100 lines of code that an AI will happily spit out for you.</p>



<p class="wp-block-paragraph">And so I think the floor is raising on people building plugins. Where if your plugin isn&#8217;t doing anything super complicated, if it&#8217;s set it and forget it, then there&#8217;s probably not going to be a market for it in the future.</p>



<p class="wp-block-paragraph">But that said, there&#8217;s this whole other area of opportunity where there&#8217;s tons of plugins that need to be built still. There&#8217;s integrations that are really complicated that you don&#8217;t want to leave to AI. There&#8217;s things around modifying payments and modifying how your checkout works and different types of products. And all of that stuff I think is still available, and I think most people will choose to pay for those sorts of things.</p>



<p class="wp-block-paragraph">But if your plugin is something, I will just say we&#8217;ve, all the ones we&#8217;ve brought in are our own plugins so far. So this new WooCommerce release that&#8217;s coming out this week is different product variations can have image galleries on each variation. That&#8217;s a thing. But that was our plugin. So we took our plugin and we put it in Core, and gave it away for free. We don&#8217;t really try to go after if somebody&#8217;s got an established community plugin and they&#8217;re supporting it. We don&#8217;t want to go after them. But we are definitely cannibalizing a few of our own plugins, and turning off a little bit of revenue we get from those to put those in Core. And that&#8217;s, we think it&#8217;s worth it in the long run to just have a better WooCommerce.</p>



<p class="wp-block-paragraph">[00:32:09] <strong>Nathan Wrigley:</strong> I think that&#8217;s a really difficult tightrope to walk, isn&#8217;t it? Because obviously you would love to have every piece of functionality available in a, you know, easy to use manner in Core, or at least all the bits and pieces that were essential. But at the same time, there&#8217;s this delicate balancing act of the community, which at the moment seems to be, how shall we say it, in a holding pattern? Let&#8217;s go with that.</p>



<p class="wp-block-paragraph">There&#8217;s a lot of uncertainty, people who have this sort of utility plugin that does this one thing, as you&#8217;ve described, it may be 100, 200 lines of code. Where in the past that was probably going to make you some nice pocket change. It does feel like that is going away.</p>



<p class="wp-block-paragraph">So if that is the calculus upon which you&#8217;re basing whether you build something into Core or not, you&#8217;re potentially swooping in and creating something for which there is no business anymore anyway, Because now in the advent of AI, anybody with half a minute can whip that same functionality up, and you might as well have it all security checked and what have you inside of Core.</p>



<p class="wp-block-paragraph">But very difficult to figure out how to balance damaging, I suppose, is the wrong word, but it&#8217;s adjacent to what I&#8217;m after. Damaging relations with community members who are great great advertisements for building on top of WooCommerce, and yet shipping all these things in Core. Difficult. I&#8217;m glad, I don&#8217;t have to square that circle.</p>



<p class="wp-block-paragraph">[00:33:23] <strong>Brian Coords:</strong> Yeah, and we have a very vocal extension developer community. They give us feedback all the time. And some of them, I think they&#8217;re well aware that they&#8217;re much more likely to be threatened by AI, than they are us wanting the functionality of their plugin in Core.</p>



<p class="wp-block-paragraph">But there&#8217;s also a general sense in WooCommerce from, like the customers, which is, &#8220;Why do I need so many plugins?&#8221; And that&#8217;s kind of a concern and that fear of, when I update WooCommerce and I have 30 to 50 extensions, which is very normal for a WooCommerce store, is each one of those going to work? Do I have to worry about that?</p>



<p class="wp-block-paragraph">And so it is also a balance where it&#8217;s almost damaging WooCommerce that you need so many plugins just to run a store. And that why do I need a plugin for this and this, you know? So we&#8217;re trying to balance that, where we want to make it feel more secure and reliable.</p>



<p class="wp-block-paragraph">But also I think a lot of those plugins are much more threatened by AI than they are us getting around. We have plenty to work on before we get around to taking other people&#8217;s plugins. We have plenty to work on our own to improve basically WooCommerce, subscriptions, all the kind of Core stuff we already manage.</p>



<p class="wp-block-paragraph">[00:34:25] <strong>Nathan Wrigley:</strong> Yeah, I feel that in the WordPress space, the most likely bit to survive, is potentially WooCommerce. Just simply because there is so much that is at stake by messing up your website by injecting a bunch of AI slop. Again, I&#8217;m doing air quotes.</p>



<p class="wp-block-paragraph">Because, this is your revenue. If you take your site down for half a minute, that really could lose you, I don&#8217;t know, thousands of dollars in orders. But I don&#8217;t know if that&#8217;s your intuition as well. It feels like brochure sites, that is very much up for debate at the moment. We&#8217;ll have to see how the landscape goes with that. But it feels like the WooCommerce bit, the e-commerce of WordPress&#8217;s community, it feels like you&#8217;re on a bit of safer ground just simply because of the revenue that&#8217;s generated by those sites and the reluctance of people to meddle with them.</p>



<p class="wp-block-paragraph">[00:35:14] <strong>Brian Coords:</strong> Yeah. I mean that&#8217;s what I&#8217;ve been yelling internally, so I&#8217;m glad you agree. I think e-commerce is definitely much more, has a much stronger moat than static brochure sites. And I think that&#8217;s what people in WordPress are sort of dealing with, which is for all these sites that are on WordPress how many of them need WordPress? How many of them need this functionality? WooCommerce definitely. You need a database, and you need security, and you need updates and you need all this stuff.</p>



<p class="wp-block-paragraph">For a marketing brochure site, you probably didn&#8217;t need it to begin with, but WordPress was easier. So the question is for those simple marketing sites, do we make WordPress easier so that they can keep using WordPress, or do we say, &#8220;No, we&#8217;re going to lean in on publishing, commerce, really complicated, heavier duty sites that probably generate more money, but maybe the total market share goes down,&#8221; I don&#8217;t know. I think that is a big question.</p>



<p class="wp-block-paragraph">[00:36:05] <strong>Nathan Wrigley:</strong> Yeah, it&#8217;s interesting. I can imagine in a decade from now, the UI for a typical brochure site almost not even a UI. It&#8217;s something that we can&#8217;t really conceive of at the moment. It might be that, you speak to a thing, and the thing reacts and amends as necessary. Maybe WordPress will have to fight that territory to keep its market share.</p>



<p class="wp-block-paragraph">But I do feel that the WooCommerce side, I think people are going to be able to justify the time put in to logging into a platform and going through a list of products and adding, &#8220;Okay, I&#8217;ve got some shoes that I&#8217;m selling over here and they come in seven different varieties. I want to sell the shoes. I&#8217;m going to upload the color palettes for each of those shoe,&#8221;. There&#8217;s just some calculus of the work that needs to be done and the maintenance that needs to be done. I feel that you&#8217;re on much, much stronger ground as you described. So yeah, I think you&#8217;ve every reason to be sanguine.</p>



<p class="wp-block-paragraph">[00:36:52] <strong>Brian Coords:</strong> Yeah, and I still think people want to log in to something and look at something. Especially with e-commerce, they want to just see a screen of how their orders are doing. They don&#8217;t want to ask AI to generate that every single second that they want to see how many orders they have, and what their revenue is for that day and all their analytics. They just want to log in and see the thing that they see every day. They don&#8217;t need to vibe code that on the fly by asking AI to generate it, right?</p>



<p class="wp-block-paragraph">[00:37:15] <strong>Nathan Wrigley:</strong> Do you know that&#8217;s really interesting? I have genuinely never thought about the desire to log into a thing, but that actually makes a lot of sense to me.</p>



<p class="wp-block-paragraph">This is going to sound extremely out there, but I&#8217;m going to say it anyway. There is something of akin to getting home when you&#8217;ve been on a long journey, and you finally get to your own front door after sleeping in hotels, beds, and all of that. There&#8217;s just something quite nice about getting into you own environment and it&#8217;s, &#8220;Ah, I&#8217;m at home.&#8221;</p>



<p class="wp-block-paragraph">And I actually have started blogging again recently, and I get a real great feeling when I log in and all that familiar stuff is there, and, &#8220;Oh, look, there&#8217;s all the pictures that I&#8217;ve posted on this website these many years.&#8221; I think there&#8217;s something there. I think that&#8217;s really curious. The idea of logging into something, being purposeful about it. Not speaking to the exact same interface that you talk to every other thing to do the job. Having a place, a URL that you go to, the environments how you&#8217;ve set it up, I can&#8217;t believe I&#8217;ve never thought of that before, but I think that&#8217;s quite profound. I hope you&#8217;re right.</p>



<p class="wp-block-paragraph">[00:38:18] <strong>Brian Coords:</strong> Yeah. I hope I&#8217;m right too. I hope that there&#8217;s just some things in life you don&#8217;t want to ask an agent to go do for you, and you just say, &#8220;Let me just click on this and change this thing.&#8221; Some things are just faster than, &#8220;All right, I&#8217;m going to text my agent, and hopefully he does it right, and then he&#8217;s going to send me a screenshot that it got done.&#8221; I mean, I love doing that kind of stuff. I do it for some things, but yeah, sometimes you&#8217;re just, &#8220;show me that same dashboard.&#8221;</p>



<p class="wp-block-paragraph">[00:38:41] <strong>Nathan Wrigley:</strong> Yeah. And I do wonder in the years to come how ready we are going to be to submit all of that control. Just the idea that an essential part of your business, like your e-commerce site could be done by an AI with very little intuition as to what&#8217;s happening once that command has been given and it updates that stuff.</p>



<p class="wp-block-paragraph">But not just that you don&#8217;t know what that thing did, what the thousand other things that were done prior to that one prompt. Okay, it looks nice at the minute, but how did it even get there? Well that was about two years of prompting. Okay. All right. Can we unpick that? Not really. We haven&#8217;t the faintest idea how it got to this. Yeah, that&#8217;s really interesting. Okay. I think I&#8217;ve asked everything I wish to ask. Is there anything you wanted to get out before we knock it on the head, Brian?</p>



<p class="wp-block-paragraph">[00:39:24] <strong>Brian Coords:</strong> No, just hopefully we&#8217;re still here in five years, not just prompting away in our basements.</p>



<p class="wp-block-paragraph">[00:39:29] <strong>Nathan Wrigley:</strong> You know what? I think if you&#8217;d have asked me that question six months ago, I had less certainty than I do now. I think I&#8217;ve seen a sort of, tsunami is the wrong word, it certainly is not that, but a general sense out in the world at at large of distrust and a move towards the sort of more artisan side of life.</p>



<p class="wp-block-paragraph">And so I think it&#8217;ll be curious to revisit this conversation in a few years time and see how that pendulum has swung. If the AI overlords are listening to this in the year 2028, please do not come and get me. I was wrong. But there we go. Let&#8217;s hope that we&#8217;ve all got somewhere to stand, a beachhead to stand in a few years. That&#8217;d be nice to think about.</p>



<p class="wp-block-paragraph">Okay, Brian, thank you so much for chatting to me today. I really appreciate it.</p>



<p class="wp-block-paragraph">[00:40:10] <strong>Brian Coords:</strong> Thank you.</p>
</div></details>



<p class="wp-block-paragraph">On the podcast today we have <a href="https://profiles.wordpress.org/bacoords/">Brian Coords</a>.</p>



<p class="wp-block-paragraph">Brian’s journey started in teaching, and after a surprise detour, thanks to a growing family and a need for new work, he jumped headfirst into WordPress, spending a decade in agency and freelance roles before landing as a Developer Advocate at WooCommerce. He’s known for his knack for explaining the complicated parts of WordPress, championing documentation, blogging, podcasting, and bridging the gap between community needs and product development.</p>



<p class="wp-block-paragraph">Brian recently delivered a talk at WordCamp US entitled “The Site Is the Source of Truth: Block Themes, AI, and Agency Workflows,” and that’s the focal point for our conversation. We start with Brian’s background in both education and development, and how he finds his DevRel role the perfect bridge between those worlds.</p>



<p class="wp-block-paragraph">We then get into the evolution of WordPress, from its early days to the present, questioning just what it is that has given the platform such staying power, especially as agencies race to adopt shiny AI tools or static site builders and are tempted to throw WordPress out with the bathwater. Brian sees unique value in the WordPress ecosystem, especially for sites with longstanding content, integrations, and complex needs, and he makes the case for why the platform is built to last.</p>



<p class="wp-block-paragraph">We talk through the idea of ‘the site as the source of truth’, using WordPress (and increasingly block themes) not only as a publishing platform, but as the repository for all your design, content, and workflow guidelines. Instead of letting generative AI run wild (and potentially create chaos), Brian outlines how agencies and product teams can centralise approved patterns, templates, and even content guidelines directly in the WordPress site, helping both AI and human users maintain brand and design consistency.</p>



<p class="wp-block-paragraph">We also unpack the state of block themes, why agency adoption has taken longer than expected, what’s coming soon for WooCommerce users, and how the move to block-based building is reducing plugin sprawl and making sites more resilient. And, of course, we wrestle with the tightrope walk of what should go into WooCommerce Core versus what is better left to the ecosystem, especially in a world where AI can spin up basic plugins in seconds.</p>



<p class="wp-block-paragraph">If you’re curious about how WordPress agencies can survive and thrive alongside AI, what the future holds for block themes, and how to build smarter, more sustainable workflows, this episode is for you.</p>



<h2 class="wp-block-heading">Useful links</h2>



<p class="wp-block-paragraph"><a href="https://www.briancoords.com">Brian&#8217;s website</a></p>



<p class="wp-block-paragraph"><a href="https://us.wordcamp.org/2026/session/the-site-is-the-source-of-truth-block-themes-ai-and-agency-workflows/">The Site Is the Source of Truth: Block Themes, AI, and Agency Workflows</a> &#8211; Brian&#8217;s presentation at WordCamp US 2026</p>



<p class="wp-block-paragraph"><a href="https://woocommerce.com">WooCommerce</a></p>



<p class="wp-block-paragraph"><a href="https://make.wordpress.org/ai/2026/02/03/content-guidelines-a-gutenberg-experiment/">Content Guidelines: A Gutenberg Experiment</a></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 07 Oct 2026 13:00:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Nathan Wrigley";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:12;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:54:"Akismet: Upgrade to the official Akismet Drupal module";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://akismet.com/?p=285183";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:71:"https://akismet.com/blog/upgrade-to-the-official-akismet-drupal-module/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:8721:"<figure class="wp-block-image size-large"><img alt="" class="wp-image-285267" height="537" src="https://akismet.com/wp-content/uploads/2026/10/akismet-and-drupal-integration-banner.png?w=1024" width="1024" /></figure>



<p class="wp-block-paragraph">If your Drupal site still runs the community Akismet module (<code>drupal/akismet</code>), the official Akismet module (<code>drupal/akismet_antispam</code>) can upgrade it in place. You swap the Composer package, run database updates, and your API key and protection settings come along. We built it so you don&#8217;t have to uninstall, reinstall, and re-enter everything. This post walks through the steps.</p>



<h3 class="wp-block-heading" id="which-sites-this-covers">Which sites this covers</h3>



<p class="wp-block-paragraph">The update needs Drupal 10.3 or later on PHP 8.1 or later. That covers sites on the community module&#8217;s 2.0.x releases and its 8.x-1.x dev branch.</p>



<p class="wp-block-paragraph">If you&#8217;re on an older setup:</p>



<ul class="wp-block-list">
<li><strong>8.x-1.0-alpha2 (Drupal 8 or 9):</strong> update the community module to 2.0.0-alpha2 while you update core, then follow this post.</li>



<li><strong>7.x:</strong> upgrade Drupal first, then install the official module fresh. Your Akismet account and API key still work.</li>
</ul>



<p class="wp-block-paragraph">The <a href="https://www.drupal.org/docs/extending-drupal/contributed-modules/contributed-module-documentation/akismet-anti-spam/migrating-from-the-community-akismet-module">migration guide on drupal.org</a> has a table for every release if you&#8217;re not sure which one you run.</p>



<h3 class="wp-block-heading" id="before-you-start">Before you start</h3>



<ul class="wp-block-list">
<li><strong>Back up the database.</strong> The update only goes one way.</li>



<li><strong>Note which roles have &#8220;Bypass Akismet protection.&#8221;</strong> The update removes that permission (more on that below).</li>



<li><strong>Plan one deploy for the whole swap.</strong> Between the Composer change and <code>drush updb</code>, spam protection is off and some admin pages break, so don&#8217;t leave a gap between them.</li>
</ul>



<h3 class="wp-block-heading">What carries over, and what doesn&#8217;t</h3>



<p class="wp-block-paragraph">These come along:</p>



<ul class="wp-block-list">
<li>Your API key</li>



<li>Your connection timeout, if it&#8217;s between 1 and 60 seconds</li>



<li>Your comment, contact and registration protection settings</li>
</ul>



<p class="wp-block-paragraph">These don&#8217;t:</p>



<ul class="wp-block-list">
<li><strong>Check history.</strong> The community module&#8217;s <code>akismet</code> table is dropped, so the Spam tab starts empty. Those rows hold submitted content, including author emails and IP addresses, and the official module has no way to erase them later. </li>



<li><strong>Per-form settings.</strong> The community module could protect some comment types or contact forms and not others. The official module has one toggle per category, and it covers all of them.</li>



<li><strong>Per-form &#8220;discard spam.&#8221;</strong> This becomes one site-wide strictness setting.</li>



<li><strong>Test mode, custom API endpoints and the &#8220;block all submissions&#8221; outage policy.</strong></li>



<li><strong>The &#8220;Bypass Akismet protection&#8221; permission.</strong> The update removes it from every role that had it. The official module&#8217;s equivalent is <code>bypass akismet</code>, and it isn&#8217;t granted automatically.</li>



<li><strong>Webform handlers.</strong> You&#8217;ll need to re-attach the Akismet handler to each webform that used it.</li>
</ul>



<p class="wp-block-paragraph">You don&#8217;t have to track any of this by hand. The update prints a report that names every item above that applies to your site.</p>



<h3 class="wp-block-heading" id="the-migration">The migration</h3>


<div class="wp-block-code">
	<div class="cm-editor">
		<div class="cm-scroller">
			
<pre>
<code class="language-shell"><div class="cm-line">composer remove drupal/akismet</div><div class="cm-line">composer require drupal/akismet_antispam <span class="tok-propertyName">-W</span></div><div class="cm-line">drush cr</div><div class="cm-line">drush updb</div></code></pre>
		</div>
	</div>
</div>


<p class="wp-block-paragraph">Run them in that order, back to back.</p>



<ol class="wp-block-list">
<li><strong><code>composer remove</code></strong> first, and leave the module installed in Drupal. Don&#8217;t uninstall it, because the update reads its database state. The official module&#8217;s <code>composer.json</code> conflicts with <code>drupal/akismet</code>, so Composer won&#8217;t install them side by side.</li>



<li><strong><code>composer require ... -W</code></strong> lets Composer update shared dependencies, like the Akismet PHP SDK or the PSR HTTP packages, if your lock file pins an older version. Without <code>-W</code>, Composer can refuse with &#8220;the package is fixed to &#8230; (lock file version).&#8221;</li>



<li><strong><code>drush cr</code></strong> before anything else. The community module shipped services that no longer exist, and Drupal still has them cached. Until you rebuild, logged-in pages return a 500 and drush commands die on shutdown. <code>drush cr</code> works when nothing else does.</li>



<li><strong><code>drush updb</code></strong> runs the update. Stay off the comment admin screens until it finishes.</li>
</ol>



		<figure class="wp-block-jetpack-videopress jetpack-videopress-player">
			<div class="jetpack-videopress-player__wrapper"> <div class="jetpack-video-wrapper"></div></div>
			
			
		</figure>
		


<p class="wp-block-paragraph">Read the report. It&#8217;s also logged to watchdog, so you won&#8217;t lose it if your terminal scrolls away. Then export and commit the new configuration:</p>


<div class="wp-block-code">
	<div class="cm-editor">
		<div class="cm-scroller">
			
<pre>
<code class="language-shell"><div class="cm-line">drush cex</div></code></pre>
		</div>
	</div>
</div>


<p class="wp-block-paragraph">On every other environment, rebuild the cache before anything else touches it:</p>


<div class="wp-block-code">
	<div class="cm-editor">
		<div class="cm-scroller">
			
<pre>
<code class="language-shell"><div class="cm-line">drush cr &amp;&amp; drush deploy</div></code></pre>
		</div>
	</div>
</div>


<h3 class="wp-block-heading" id="check-that-it-worked">Check that it worked</h3>



<ul class="wp-block-list">
<li><strong>Settings:</strong> confirm your protection toggles at <code>/admin/config/content/akismet</code>.</li>



<li><strong>Status report:</strong> check the Akismet entries at <code>/admin/reports/status</code>.</li>



<li><strong>Test submission:</strong> post a comment as an anonymous user named <code>akismet-guaranteed-spam</code>. Akismet always flags that name, so the comment should land in the Spam tab.</li>
</ul>



<h3 class="wp-block-heading" id="already-on-the-official-module-1-0">Already on the official module 1.0?</h3>



<p class="wp-block-paragraph">Upgrading to 1.1 is one command and a database update:</p>


<div class="wp-block-code">
	<div class="cm-editor">
		<div class="cm-scroller">
			
<pre>
<code class="language-shell"><div class="cm-line">composer update drupal/akismet_antispam <span class="tok-propertyName">-W</span></div><div class="cm-line">drush updb</div></code></pre>
		</div>
	</div>
</div>


<p class="wp-block-paragraph">The <code>-W</code> matters here. Version 1.1 needs Akismet PHP SDK 1.5, and if your lock file still pins 1.4, Composer stops with:</p>


<div class="wp-block-code">
	<div class="cm-editor">
		<div class="cm-scroller">
			
<pre>
<code><div class="cm-line">drupal/akismet_antispam 1.1.0 requires automattic/akismet-sdk ^1.5 -&gt; found automattic/akismet-sdk[v1.5.0] but the package is fixed to v1.4.0 (lock file version).</div></code></pre>
		</div>
	</div>
</div>


<p class="wp-block-paragraph"><code>-W</code> (short for <code>--with-dependencies</code>) lets Composer update the SDK along with the module.</p>



<h3 class="wp-block-heading" id="questions">Questions</h3>



<p class="wp-block-paragraph">If something in the report surprises you, or the update doesn&#8217;t go the way this post says, open an issue in the <a href="https://www.drupal.org/project/issues/akismet_antispam">issue queue</a>. The <a href="https://www.drupal.org/docs/extending-drupal/contributed-modules/contributed-module-documentation/akismet-anti-spam/migrating-from-the-community-akismet-module">migration guide</a> and the module&#8217;s README have the full details.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 06 Oct 2026 22:13:52 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Derek Springer";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:13;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:68:"WordPress.org blog: WordPress 7.1.3 Maintenance and Security Release";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"https://wordpress.org/news/?p=21753";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:84:"https://wordpress.org/news/2026/10/wordpress-7-1-3-maintenance-and-security-release/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:5439:"<p class="wp-block-paragraph">This security and maintenance release features 7 security fixes and <a href="https://core.trac.wordpress.org/query?milestone=7.1.3&amp;status=closed&amp;order=priority&amp;col=id&amp;col=summary&amp;col=status&amp;col=milestone&amp;col=owner&amp;col=type&amp;col=priority">4 bug fixes</a>.</p>



<p class="wp-block-paragraph"><strong>Because this is a security release, it is recommended that you update your sites immediately.</strong></p>



<p class="wp-block-paragraph">You can <a href="https://wordpress.org/wordpress-7.1.3.zip">download WordPress 7.1.3 from WordPress.org</a>, or visit your WordPress Dashboard, click “Updates”, and then click “Update Now”. If you have sites that support automatic background updates, the update process will begin automatically.</p>



<h2 class="wp-block-heading">Security updates included in this release</h2>



<p class="wp-block-paragraph">The security team would like to thank the following people and organizations for responsibly reporting vulnerabilities, and allowing them to be fixed in this release:</p>



<ul class="wp-block-list">
<li>A stored XSS on the Comments administration page, exploitable via pending comments, reported by <a href="https://trailofbits.com/">Trail of Bits</a> in collaboration with OpenAI.</li>



<li>A DoS issue in the <code>WP_Http::make_absolute_url()</code> method, reported by Anthropic</li>



<li>A second-Order SQL injection in WordPress WXR export, reported by Anthropic</li>



<li>A weakness allowing Author role users to sticky posts, reported by Anthropic</li>



<li>Unauthenticated disclosure of comments on private &amp; unpublished posts, reported by <a href="https://patchstack.com/">Ananda Dhakal from Patchstack</a></li>



<li>Imgur embeds are vulnerable to XSS, reported by <a href="https://jackfromeast.github.io/">Zhengyu Liu</a>, <a href="https://jesse-yang.com/">Jingcheng Yang</a>, and <a href="https://gvzhong.github.io/">Gavin Zhong</a></li>



<li>Forgeable parameters passed to the <code>{status}_{type}</code> hook can lead to action name collision, reported by Alex Concha of the WordPress security team</li>
</ul>



<h2 class="wp-block-heading">Thank you to these WordPress contributors</h2>



<p class="wp-block-paragraph">This release was led by <a href="https://profiles.wordpress.org/whyisjake/">Jake Spurlock</a>.</p>



<p class="wp-block-paragraph">WordPress 7.1.3 would not have been possible without the contributions of the following people. Their asynchronous coordination to deliver maintenance and security fixes into a stable release is a testament to the power and capability of the WordPress community.</p>



<p class="wp-block-paragraph"><a href="https://w.org/@jorbin">Aaron Jorbin</a>, <a href="https://w.org/@adamsilverstein">Adam Silverstein</a>, <a href="https://w.org/@adrianmoldovanwp">Adi Moldovan</a>, <a href="https://w.org/@adrianduffell">Adrian Duffell</a>, <a href="https://w.org/@xknown">Alex Concha</a>, <a href="https://w.org/@arkaprabhachowdhury">Arkaprabha Chowdhury</a>, <a href="https://w.org/@iamchitti">Deepak Kumar</a>, <a href="https://w.org/@donniam">donniam</a>, <a href="https://w.org/@ehtis">Ehtisham Siddiqui</a>, <a href="https://w.org/@whyisjake">Jake Spurlock</a>, <a href="https://w.org/@audrasjb">Jb Audras</a>, <a href="https://w.org/@jeremyfelt">Jeremy Felt</a>, <a href="https://w.org/@joedolson">Joe Dolson</a>, <a href="https://w.org/@johnbillion">John Blackbourn</a>, <a href="https://w.org/@jonsurrell">Jon Surrell</a>, <a href="https://w.org/@desrosj">Jonathan Desrosiers</a>, <a href="https://w.org/@kgagne">Ken Gagne</a>, <a href="https://w.org/@khokansardar">Khokan Sardar</a>, <a href="https://w.org/@lancewillett">Lance Willett</a>, <a href="https://w.org/@lucatume">lucatume</a>, <a href="https://w.org/@marcs0h">marcs0h</a>, <a href="https://w.org/@peterwilsoncc">Peter Wilson</a>, <a href="https://w.org/@paulkevan">Paul Kevan</a>, <a href="https://w.org/@therssoftware">RS Software</a>, <a href="https://w.org/@rfaile313">Rudy Faile</a>, <a href="https://w.org/@sergeybiryukov">Sergey Biryukov</a>, <a href="https://w.org/@siliconforks">siliconforks</a>, <a href="https://w.org/@smerriman">smerriman</a>, <a href="https://w.org/@sabernhardt">Stephen Bernhardt</a>, <a href="https://w.org/@suryakantupadhyay">Suryakant Upadhyay</a>, <a href="https://w.org/@vortfu">vortfu</a>, <a href="https://w.org/@webverts">webVerts</a>, <a href="https://w.org/@westonruter">Weston Ruter</a>, <a href="https://w.org/@yogeshbhutkar">Yogesh Bhutkar</a></p>



<h2 class="wp-block-heading">Backports</h2>



<p class="wp-block-paragraph">As a courtesy, the security fixes are being backported, where necessary, to all branches eligible to receive security fixes (currently through 4.7). As a reminder, <strong>only the most recent version of WordPress is actively supported</strong>. The backports are in progress and will ship as they become ready.</p>



<h2 class="wp-block-heading">How to contribute</h2>



<p class="wp-block-paragraph">To get involved in WordPress core development, head over to Trac, <a href="https://core.trac.wordpress.org/report/6">pick a ticket</a>, and join the conversation in the <a href="https://wordpress.slack.com/archives/C02RQBWTW">#core</a> channel. Need help? Check out the <a href="https://make.wordpress.org/core/handbook/">Core Contributor Handbook</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 06 Oct 2026 17:00:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Jake Spurlock";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:14;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:123:"Open Channels FM: Open Source Maintainers Defend Against AI Spam,  Linux Data Trends and WordPress Accessibility Challenges";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2563376";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:128:"https://openchannels.fm/open-source-maintainers-defend-against-ai-spam-linux-data-trends-and-wordpress-accessibility-challenges/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:130:"AI-driven growth presents challenges in security and accessibility and infrastructure hurdles that technology teams cannot ignore.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 06 Oct 2026 15:45:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"Bob Dunn";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:15;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:68:"Open Channels FM: The Essential Human Touch in Genealogical Research";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2562236";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:75:"https://openchannels.fm/the-essential-human-touch-in-genealogical-research/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:382:"As artificial intelligence becomes more integrated into genealogical research, it is tempting to imagine a future where longstanding mysteries are unraveled with a few keystrokes. AI tools can now scan, transcribe, and sort through centuries of records, but the heart of successful genealogy still depends on something machines cannot replicate: the human touch. No matter [&#8230;]";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 06 Oct 2026 10:42:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:16:"Open Channels FM";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:16;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:82:"OpenStation Blog: Someone Said “I Hate OpenStation.” That Was Actually Useful.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"https://openstation.blog/?p=1400";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:93:"https://openstation.blog/2026/10/06/someone-said-i-hate-openstation-that-was-actually-useful/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:5333:"<p class="wp-block-paragraph">A few days ago, someone opened a support thread about <a href="https://wordpress.org/plugins/allterrain-forms/">AllTerrain Forms</a> and, in the middle of otherwise useful feedback, wrote something very direct: “I hate OpenStation.”</p>



<p class="wp-block-paragraph">Obviously that is not the nicest sentence to read when you are working on the product, but at the same time it immediately got my attention because this is exactly the kind of feedback that can be useful if you don’t take it personally.</p>



<p class="wp-block-paragraph">So instead of trying to explain why OpenStation is good, or why we made certain decisions, I asked a very simple question: what exactly makes you hate it?</p>



<p class="wp-block-paragraph">Her answer was actually very good.</p>



<p class="wp-block-paragraph">She works on a laptop, so screen space matters a lot. OpenStation was opening windows too small for her workflow, which meant that one of her first actions was always maximizing them. She also didn’t like losing the visible URL because she regularly copies URLs into emails, project trackers or messages. On top of that, her users are not very technical, and from her point of view OpenStation was adding another layer to WordPress that she would eventually have to explain and support.</p>



<p class="wp-block-paragraph">She basically said that browser tabs already exist, users understand them, they use the whole screen, and they don’t hide the URL.</p>



<p class="wp-block-paragraph">And I think this is exactly where building software becomes interesting, because from our side all of those decisions had reasons behind them, but reasons don’t really matter if the final experience is worse for the person using it.</p>



<p class="wp-block-paragraph">None of these are theoretical product discussions. They are very concrete things that someone hit while trying to use the software for real work.</p>



<p class="wp-block-paragraph">That matters a lot to me.</p>



<p class="wp-block-paragraph">We started discussing these points immediately, and one of them has already made it into the next OpenStation release.</p>



<figure class="wp-block-image aligncenter size-large"><img alt="OpenStation Preferences interface displaying settings for window appearance and behavior, including options for window focus, corners, and dimming effects." class="wp-image-1403" height="716" src="https://i0.wp.com/openstation.blog/wp-content/uploads/2026/10/image.png?resize=1024%2C716&#038;ssl=1" width="1024" /></figure>



<p class="wp-block-paragraph">Users will now be able to choose how new windows open: using the current default behaviour, maximized, or focused. Focused mode maximizes the new window and minimizes the other windows on the same desk, so people working on smaller screens can have something much closer to the experience they expect.</p>



<p class="wp-block-paragraph">This came directly from that kind of feedback, and the implementation is already merged:</p>



<p class="wp-block-paragraph"><a href="https://github.com/WordPress/openstation/pull/964">PR #964: Preferences: choose how newly opened windows appear</a></p>



<p class="wp-block-paragraph">And this is really the point.</p>



<p class="wp-block-paragraph">We obviously have our own vision for OpenStation. We believe WordPress can have a much better working environment than the traditional admin experience, and there are many things we still want to explore there. But having a strong idea of where the product should go does not mean pretending every decision we make is correct.</p>



<p class="wp-block-paragraph">Sometimes the most useful feedback is not “great release” or “this looks amazing”. Sometimes it is someone telling you that a window is too small, that they want the URL back, that something scrolls when it shouldn’t, or simply that they don’t see the benefit of what you built.</p>



<p class="wp-block-paragraph">That kind of feedback forces you to look at the product from outside your own head, which is probably one of the hardest things to do when you have been working on it every day for months.</p>



<p class="wp-block-paragraph">For me, OpenStation becoming more mature is not only about adding more apps, more features or more ambitious ideas. A big part of maturity is improving all those small things that make the product feel natural, predictable and less annoying to use.</p>



<p class="wp-block-paragraph">And I think there is also something important here about open source. People can complain, explain exactly what does not work for them, and a few days later they can literally see the code that changes that behaviour.</p>



<p class="wp-block-paragraph">That is a pretty healthy way to build software.</p>



<p class="wp-block-paragraph">So yes, tell us when OpenStation is great, but especially tell us when it sucks. We may not agree with every suggestion, and we obviously cannot build every requested feature, but if there is a real problem behind the feedback, we want to understand it.</p>



<p class="wp-block-paragraph">In this case, someone said “I hate OpenStation.”</p>



<p class="wp-block-paragraph">Fair enough.</p>



<p class="wp-block-paragraph">A few days later, OpenStation got better because of it.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 06 Oct 2026 08:54:53 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Daniel López";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:17;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:16:"Matt: Beeper MCP";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:23:"https://ma.tt/?p=155119";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:33:"https://ma.tt/2026/10/beeper-mcp/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:351:"<p class="wp-block-paragraph">Fellow <a href="https://automattic.com/">Automattician</a> Job Thomas, down in Cape Town, South Africa, has a <a href="https://job.blog/2026/09/17/school-communication-is-too-much-so-my-ai-does-it/">lovely story about using Claude and the Beeper MCP to wrangle all the group chats for his daughter&#8217;s sports</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 06 Oct 2026 06:35:11 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Matt";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:18;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:111:"Open Channels FM: Technology’s Fast Feedback Loop with Triumph of the Nerds, Agile AI, and WordPress Security";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2563290";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:113:"https://openchannels.fm/technologys-fast-feedback-loop-with-triumph-of-the-nerds-agile-ai-and-wordpress-security/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:88:"Faster tech means new challenges from AI feedback loops to WordPress security incidents.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 05 Oct 2026 15:00:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"Bob Dunn";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:19;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:66:"Open Channels FM: Topics in Tech Business, It’s Rinse and Repeat";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2560606";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:64:"https://openchannels.fm/topics-in-business-its-rinse-and-repeat/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:78:"Sometime we think, been there, done that, but hey, not everyone has done that.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 05 Oct 2026 09:54:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:3:"Bob";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:20;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:39:"Akismet: Akismet now supports Drupal 12";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:28:"http://akismet.com/?p=285135";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:56:"https://akismet.com/blog/akismet-now-supports-drupal-12/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:5034:"<figure class="wp-block-image size-large"><img alt="" class="wp-image-285145" height="537" src="https://akismet.com/wp-content/uploads/2026/09/ad12-2.png?w=1024" width="1024" /></figure>



<p class="wp-block-paragraph"><a href="https://www.drupal.org/project/akismet_antispam/releases/1.1.0">Version 1.1.0</a> of the <a href="https://www.drupal.org/project/akismet_antispam">official Akismet Drupal module</a> is out with support for Drupal 12. If you&#8217;re planning your move to 12, spam protection won&#8217;t hold you back. Here are the highlights.</p>



<h2 class="wp-block-heading" id="drupal-12-from-day-one">Drupal 12 from day one</h2>



<p class="wp-block-paragraph">The module now runs on Drupal 10.3+, 11 and 12. On Drupal 12, Akismet checks comments and user registrations as soon as you install it, since both live in core. Contact forms, webforms, and the Key module will be supported as soon as they&#8217;re ready for D12.</p>



<h2 class="wp-block-heading" id="what-else-is-new-in-1-1-0">What else is new in 1.1.0</h2>



<h3 class="wp-block-heading" id="better-spam-scoring">Better spam scoring</h3>



<p class="wp-block-paragraph">Every check now gives Akismet a fuller picture of each submission. The module&#8217;s bot detection watches how someone fills out a form: how long they take, how they type, and how they scroll, click or tap. In 1.1.0, all of those signals feed straight into Akismet&#8217;s spam scoring. With more context, Akismet can better tell a real person from a bot, so you should see more spam caught and fewer real messages flagged by mistake.</p>



<h3 class="wp-block-heading" id="better-gdpr-export">Better GDPR export</h3>



<p class="wp-block-paragraph"><code>drush akismet:gdpr-export</code> now takes <code>--format=json</code> (or <code>csv</code> and <code>yaml</code>) and returns the full stored record for each match, including the original submission. That makes subject access requests easier to answer completely.</p>



<p class="wp-block-paragraph">The export also withholds the moderator&#8217;s identity, as GDPR Article 15(4) allows.</p>



<h3 class="wp-block-heading" id="clearer-warnings-about-your-stored-api-key">Clearer warnings about your stored API key</h3>



<p class="wp-block-paragraph">The status report now warns you about a leftover copy in yoursettings and stays visible until you deal with it. A new <strong>Delete stored API key</strong> form removes it in one step. You&#8217;ll find the link on the settings page and in the status report.</p>



<h2 class="wp-block-heading" id="coming-from-the-community-module">Coming from the community module?</h2>



<p class="wp-block-paragraph">Before the official module, some Drupal sites used the community-maintained <a href="https://www.drupal.org/project/akismet">Akismet module</a> (<code>drupal/akismet</code>). That project is no longer maintained. If you&#8217;re still running it on Drupal 10.3 or later, 1.1.0 can take over your install in place. Your API key, connection timeout and protection settings carry over, and the update prints a report of everything it migrated, changed or dropped. Our <a href="https://www.drupal.org/docs/extending-drupal/contributed-modules/contributed-module-documentation/akismet-anti-spam/migrating-from-the-community-akismet-module">migration guide on drupal.org</a> walks through the process.</p>



<h2 class="wp-block-heading" id="get-started">Get started</h2>



<p class="wp-block-paragraph">You&#8217;ll need an Akismet API key. Grab one from our <a href="https://akismet.com/pricing/">pricing page</a>. It&#8217;s free for personal sites.</p>



<p class="wp-block-paragraph">For a new install:</p>


<div class="wp-block-code has-background">
	<div class="cm-editor">
		<div class="cm-scroller">
			
<pre>
<code><div class="cm-line">composer require drupal/akismet_antispam</div></code></pre>
		</div>
	</div>
</div>


<p class="wp-block-paragraph">If you&#8217;re already on 1.0, update the module along with the Akismet PHP SDK it depends on, then run the database updates:</p>


<div class="wp-block-code has-background">
	<div class="cm-editor">
		<div class="cm-scroller">
			
<pre>
<code><div class="cm-line">composer update drupal/akismet_antispam --with-dependencies</div><div class="cm-line">drush updb</div></code></pre>
		</div>
	</div>
</div>


<p class="wp-block-paragraph">The module needs Drupal 10.3, 11 or 12 and PHP 8.1 or newer, or the newer PHP your Drupal core requires.</p>



<p class="wp-block-paragraph">Found a bug or have an idea? Tell us in the <a href="https://www.drupal.org/project/issues/akismet_antispam">issue queue</a>.</p>



<p class="wp-block-paragraph">New to the module? Start with our <a href="https://akismet.com/blog/introducing-the-official-akismet-drupal-module/">introduction to the official Akismet Drupal module</a>, or see how it&#8217;s built on the <a href="https://akismet.com/blog/introducing-the-official-akismet-php-sdk/">official Akismet PHP SDK</a>.</p>



<p class="wp-block-paragraph"></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 02 Oct 2026 18:59:59 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Derek Springer";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:21;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:93:"Open Channels FM: Beyond Rants, Productive Discussions and the Mystery of Poor Design Choices";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2563201";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:99:"https://openchannels.fm/beyond-rants-productive-discussions-and-the-mystery-of-poor-design-choices/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:141:"Bob Dunn reflects on online conversation styles and an infamous hardware design blunder, offering unsolicited solutions and food for thought.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 02 Oct 2026 12:02:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"Bob Dunn";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:22;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:80:"Open Channels FM: Why We Build Systems aka Zach and Carl’s Emporium of Madness";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2563171";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:84:"https://openchannels.fm/why-we-build-systems-aka-zach-and-carls-emporium-of-madness/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:225:"In this episode, hosts Zach and Carl discuss adapting to technological change, personal reinvention, and the impact of AI on creativity and web development, emphasizing diverse income strategies and effective ADHD management.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 01 Oct 2026 11:41:11 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"Bob Dunn";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:23;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:53:"Open Channels FM: The Jerks and Flows of the Open Web";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:33:"https://openchannels.fm/?p=114879";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:40:"https://openchannels.fm/jerks-and-flows/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:102:"You may start something and then boom, it's over. Or an idea that disappears as quickly as it appears.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 30 Sep 2026 15:21:41 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:3:"Bob";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:24;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:82:"WPTavern: #235 – Rob Pugh and Tony Arcangelini on Bringing Podcasting to Jetpack";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:48:"https://wptavern.com/?post_type=podcast&p=208505";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:96:"https://wptavern.com/podcast/235-rob-pugh-and-tony-arcangelini-on-bringing-podcasting-to-jetpack";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:49098:"<details>Transcript<div>
<p class="wp-block-paragraph">[00:00:19] <strong>Nathan Wrigley:</strong> Welcome to the Jukebox Podcast from WP Tavern. My name is Nathan Wrigley.</p>



<p class="wp-block-paragraph">Jukebox is a podcast which is dedicated to all things WordPress, the people, the events, the plugins, the blocks, the themes, and in this case, bringing podcasting to Jetpack.</p>



<p class="wp-block-paragraph">If you&#8217;d like to subscribe to the podcast, you can do that by searching for WP Tavern in your podcast player of choice, or by going to wptavern.com/feed/podcast, and you can copy that URL into most podcast players.</p>



<p class="wp-block-paragraph">If you have a topic that you&#8217;d like us to feature on the podcast, I&#8217;m keen to hear from you and hopefully get you, or your idea, featured on the show. Head to wptavern.com/contact/jukebox, and use the form there.</p>



<p class="wp-block-paragraph">So on the podcast today we have Rob Pugh and Tony Arcangelini. Rob and Tony are longstanding members of the Automattic team with extensive backgrounds in marketing, product, and software development. They&#8217;ve spent years building tools for creators, writers, podcasters, and everyone in between, and now they&#8217;re fully immersed in WordPress&#8217;s evolving podcasting capabilities.</p>



<p class="wp-block-paragraph">If you&#8217;ve been looking for ways to run your podcast from your own WordPress site, this conversation is for you. Rob and Tony dive into the new Jetpack podcasting features, and why they made the leap from WordPress.com&#8217;s basic audio offerings, to a more robust, integrated solution, within Jetpack.</p>



<p class="wp-block-paragraph">They talk about what makes WordPress and Jetpack such a powerful home for creators. The ability to bring your newsletter, blog, podcast, and all your content and communication under one roof, all while keeping ownership of your data.</p>



<p class="wp-block-paragraph">We talk through the advantages of keeping your content out of walled gardens like Substack and Patreon, and the value of flexibility, whether that&#8217;s adding WooCommerce to sell merch or customising your site&#8217;s look.</p>



<p class="wp-block-paragraph">Rob and Tony breakdown just how easy it is to start your show. Drop audio into a post, set your category, and let Jetpack handle the rest. From distributing your RSS feed to major podcast apps, to sending out newsletters, and automated social posts. They also get into how integrations with PocketCasts and Jetpack AI make content creation, transcription, and distribution smoother than ever before. Plus how WordPress is open Foundation promises you&#8217;ll never be locked in.</p>



<p class="wp-block-paragraph">If you are a creator wondering how the next generation of podcasting fits into the WordPress ecosystem, or just want an easier way to launch and grow your show, this episode is for you.</p>



<p class="wp-block-paragraph">If you&#8217;re interested in finding out more, you can find all of the links in the show notes by heading to wptavern.com/podcast, where you&#8217;ll find all the other episodes as well.</p>



<p class="wp-block-paragraph">And so without further delay, I bring you Rob Pugh and Tony Arcangelini.</p>



<p class="wp-block-paragraph">I am joined on the podcast by Rob Pugh and Tony Arcangelini. Hello, both.</p>



<p class="wp-block-paragraph">[00:03:23] <strong>Rob Pugh:</strong> Hey, how&#8217;s it going, Nathan?</p>



<p class="wp-block-paragraph">[00:03:24] <strong>Tony:</strong> Hello, Nathan.</p>



<p class="wp-block-paragraph">[00:03:25] <strong>Nathan Wrigley:</strong> Nice to have you both with us.</p>



<p class="wp-block-paragraph">Today we&#8217;re going to be talking about something which is actually genuinely dear to my heart because we&#8217;re going on about podcasts. Yay!</p>



<p class="wp-block-paragraph">I&#8217;ve been in the podcasting space for decades, and WordPress has been the place where I&#8217;ve done it every single episode. I&#8217;m entirely indebted to WordPress for the capacity to do all of the podcasting I&#8217;ve done. But I&#8217;ve never done it inside of Jetpack, because until recently, I don&#8217;t think that was possible. So that&#8217;s what we&#8217;re going to talk about today.</p>



<p class="wp-block-paragraph">First of all, I&#8217;ll just go round the houses. I&#8217;ll start with Rob. Would you mind giving us just a quick potted bio of what it is that you do over at Automattic, Jetpack, whatever it is that you want to mention.</p>



<p class="wp-block-paragraph">[00:04:04] <strong>Rob Pugh:</strong> Yeah, so I&#8217;ve worked at Automattic for seven years. I&#8217;ve been in marketing and now focused more on product, but I like to do a bit of everything. And I work mostly with tools for people that create stuff. So podcasts fit right in there, and we are excited to build out this feature.</p>



<p class="wp-block-paragraph">[00:04:19] <strong>Nathan Wrigley:</strong> Nice. Thank you. Tony.</p>



<p class="wp-block-paragraph">[00:04:21] <strong>Tony:</strong> Yeah. I&#8217;ve also worked for Automattic for about eight years now. I do software development, and so I have had firsthand in building everything that we&#8217;re talking about today.</p>



<p class="wp-block-paragraph">[00:04:31] <strong>Nathan Wrigley:</strong> Okay, thank you very much.</p>



<p class="wp-block-paragraph">Now, just before we started recording, I was on the call with Tony before Rob joined in and you labored the point, not labored, but you mentioned that you were in the sort of creator side of Automattic. I didn&#8217;t know that existed, but that to me is about the most interesting bit of any organization. You know, the bit where the musicians come, and the poets come and the writers come and the podcasters, and the videos and the YouTubers, and all of that come. I think that&#8217;s really interesting, and I didn&#8217;t realise there was a wing of the business entirely aligned to that. But I guess I&#8217;ve been schooled, and now I know. So podcasting definitely comes under that banner.</p>



<p class="wp-block-paragraph">Okay so I didn&#8217;t know this existed, and I think it didn&#8217;t exist, but maybe Tony can redirect me a little bit here. Podcasting in the WordPress space, I think you could do more or less everything that we&#8217;re about to talk about inside of wordpress.com until recently, but now it&#8217;s shipped inside of Jetpack. First of all, I&#8217;ll just send that one to Tony. Is that true? Is this all like a port of things into Jetpack from .com?</p>



<p class="wp-block-paragraph">[00:05:32] <strong>Tony:</strong> I&#8217;d say it&#8217;s a little bit more than a port. So we built a very basic feature of podcasting in WordPress.com to offer WordPress.com users. It was very basic. It was just the feed. Basically what you see in the free offerings right now. The ability to drag an audio into a post and for that post to then become a podcast episode. And then we had a curated RSS feed that was available. And then very basic, the core basic iTunes tags that are needed to be able to be picked up by these apps.</p>



<p class="wp-block-paragraph">That existed there. It was a bit outdated. It hadn&#8217;t been touched in a long time, and so we felt like it would be a great tool to leverage for creators. Giving them a better product, something that would be useful with stats and the ability to manage your episodes and all of that. And we figured if we were going to put all this effort into it, that we should probably make it more widely available. And so Jetpack was, I think, the natural fit for us.</p>



<p class="wp-block-paragraph">[00:06:26] <strong>Nathan Wrigley:</strong> Yeah, I&#8217;m kind of curious how it&#8217;s ended up in Jetpack and not just its own plugin. Is it because you&#8217;re leveraging the other things that Jetpack can do? Are there sort of dependencies, if you know what I mean, where, okay, it just makes sense because Jetpack already does that piece of the puzzle, and we can just build over the top of that?</p>



<p class="wp-block-paragraph">Or is it just the brand recognition, the fact that you&#8217;ve got an email list that you don&#8217;t need to convert and they can just toggle a switch and automatically have got podcasts? What was the reasoning on putting it inside of Jetpack and not just its own thing?</p>



<p class="wp-block-paragraph">[00:06:54] <strong>Tony:</strong> I would say, at least from an engineering perspective, there&#8217;s stuff that&#8217;s in it that is exclusively within Jetpack. So, the ability to do stats, that&#8217;s a hard thing to do when you&#8217;re having a self-hosted site, to be able to watch and see what apps are actually touching those download files, and then be able to aggregate them all in one place and then give them back to you in a way that&#8217;s easy.</p>



<p class="wp-block-paragraph">So, at least from an architectural perspective, Jetpack was the easiest because it allows us to leverage some of the endpoints that are already there, and use a lot of those tools.</p>



<p class="wp-block-paragraph">But then secondly, I think it&#8217;s also from an overall product perspective, being able to put it alongside other features like newsletters. Where you can have a newsletter, you can be able to take it into the reader. Have this one episode that now spans across multiple different avenues to be consumed, is I think, also another big benefit in putting it into Jetpack. As opposed to just dropping another, because there&#8217;s already a lot of plugins out there, a few big plugins that you can grab for free that do podcasting.</p>



<p class="wp-block-paragraph">[00:07:56] <strong>Nathan Wrigley:</strong> I think one of the big bits that I realised early on in my podcasting journey was that you&#8217;re not really just trying to create an audio feed. It&#8217;s more useful as a podcast if you&#8217;ve got this kind of wrap around thing. So like you say, you&#8217;ve got a home which is yours, AKA your WordPress website. But also things like the capacity to send out an email if people are interested in subscribing, and they don&#8217;t necessarily have a podcast player that they use all the time, but they do want to consume your content.</p>



<p class="wp-block-paragraph">The fact that they can subscribe to a newsletter, you click publish, that newsletter automatically drops in their inbox. It just makes sense that all the jigsaw pieces that a podcaster needs, it feels like WordPress has had forever.</p>



<p class="wp-block-paragraph">And there is some part of me which is curious that it&#8217;s taken this long to come into the, let&#8217;s say, .org side of WordPress. Because all of the different parts, the newsletter, the RSS feed, the blog posting, all of that stuff has been available. It just kind of never got joined up. It strikes me as odd because people have moved over to Patreon, Substack has become this whole thing over the last decade. And really it felt like WordPress had that audience a decade ago.</p>



<p class="wp-block-paragraph">Maybe it&#8217;ll claw it back. I certainly hope it does, but it feels like a lot of people have left the WordPress ecosystem for their podcasting because that stuff wasn&#8217;t available. Rob, maybe you want to take that one? It&#8217;s not really a question, more of an observation.</p>



<p class="wp-block-paragraph">[00:09:16] <strong>Rob Pugh:</strong> Yeah, there&#8217;s a lot to unpack there. I agree. I think we were a little late in bringing some of these tools to wordpress.org. But I think we&#8217;re seeing the renewed focus across the technology space on ownership.</p>



<p class="wp-block-paragraph">WordPress has remained the best way to do that. And for us to be able to offer these tools to users. It shows everyone that you can, as you said, own your blog your newsletter, your podcast, together. And it does make sense for us to offer all of these tools in one space.</p>



<p class="wp-block-paragraph">I like to think of it going back to the origins of WordPress, and we started as blogging, everyone getting your thoughts out there and sharing them. Meeting new people, engaging and creating communities. And podcast is just another medium. We provide that for the written word, so of course we should try and provide that for the spoken word as well. So I do hope that we can show people the benefits, and the ease of having it all together and come back and give us a try.</p>



<p class="wp-block-paragraph">[00:10:11] <strong>Nathan Wrigley:</strong> Yeah. I think for me at least anyway, that argument is embedded in my soul. The idea of owning your own content on the web is really important. It&#8217;d be interesting to see in the year 2026, 2027 and going forward how much that stuff really matters. I&#8217;m just curious, in the age of AI whether people still want to own anything at all. But it&#8217;ll be certainly interesting to see.</p>



<p class="wp-block-paragraph">[00:10:30] <strong>Rob Pugh:</strong> Sorry, yeah, weigh in on that. I think we&#8217;ve seen it over decades and comes in waves. When social media started it was really exciting, and people ran and then saw some of the pitfalls, and they start coming back.</p>



<p class="wp-block-paragraph">And then recently you mentioned Substack, and I loved Substack when it started. It was a space for some serious dialogue, and a place for writers engage. And then over time, well, we need that VC money, and now it&#8217;s basically another social media site. And you realise, oh I don&#8217;t really own my data, I just own a Substack, and how valuable is that? And it&#8217;s coming back.</p>



<p class="wp-block-paragraph">And I think AI, it&#8217;s becoming even, the cycles are quicker now. AI&#8217;s incredible, I use it all the time. I use it to help come up with prototypes for how to best display this podcast product. But, you&#8217;ll see quickly that you don&#8217;t own anything, and you need to have a home like WordPress. And you retain ownership of your audience, and your data and your posts and your podcasts, and that&#8217;s, I think, never going to go away, and AI&#8217;s only going to reinforce that for people.</p>



<p class="wp-block-paragraph">[00:11:23] <strong>Nathan Wrigley:</strong> Yeah, I think one of the curious things as well is if you want to do anything outside of the normal that the platform will allow, so let&#8217;s take the example of Substack. There&#8217;s a limited subset of things that it can do. The bedrock of what it does I&#8217;m sure is excellent. I confess I&#8217;ve never used it, but I&#8217;ve seen many people deploy it for their own podcast, so you know, it must work.</p>



<p class="wp-block-paragraph">But the minute you want to stray outside of those boundaries, and you want to do something a little bit different, I don&#8217;t know, you might want to sell some merchandise or something like that. Well just pop WooCommerce on top of your website and you&#8217;re off to the races.</p>



<p class="wp-block-paragraph">Or, I don&#8217;t know, you want to have a different flavor in the way it looks at Christmas or something, well you just adapt the theme. And I&#8217;m, imagining good luck doing that over on these proprietary platforms. I don&#8217;t know if that&#8217;s possible, but it certainly would be a lot harder than it would be on the WordPress side I would have thought.</p>



<p class="wp-block-paragraph">[00:12:08] <strong>Rob Pugh:</strong> For sure the customisation expanding is all very important, but to me even more important is just that it feels like Substack is just another platform that&#8217;s changing the rules on their people midstream, and if you don&#8217;t like the direction of. Like tried it before and it was nice to have a non-social media site to have serious writing and reading of other serious authors, and now I&#8217;m getting short form reel videos on my homepage, and I didn&#8217;t sign up for this.</p>



<p class="wp-block-paragraph">And if you&#8217;re a creator over there, you might be stuck. How do you port your audience over? It&#8217;s technically possible, so they say they&#8217;re open, but it&#8217;s a pain, and people don&#8217;t want to leave. And if you&#8217;re actually successful, they take 10%, which is great when you&#8217;re zero paid subscribers. But, there&#8217;s people paying $10,000 a month to Substack.</p>



<p class="wp-block-paragraph">[00:12:48] <strong>Nathan Wrigley:</strong> They take 10%?</p>



<p class="wp-block-paragraph">[00:12:49] <strong>Rob Pugh:</strong> 10% no matter what, which is great if you&#8217;re free, but if you have 100 paid subscribers paying you $10 a month, suddenly it&#8217;s insane. Like it&#8217;s a terrible deal and people feel stuck. Like WordPress even, wordpress.com, jetpack, if don&#8217;t like those rules, we can&#8217;t change them too much. You can go to any of the other great podcast hosts, or plugins.</p>



<p class="wp-block-paragraph">[00:13:09] <strong>Nathan Wrigley:</strong> Yeah, I guess that&#8217;s a curious thing. And then you can embed those on your WordPress website and just carry right on as if nothing had happened. Yeah, that&#8217;s a really interesting point.</p>



<p class="wp-block-paragraph">[00:13:15] <strong>Rob Pugh:</strong> Exactly.</p>



<p class="wp-block-paragraph">[00:13:16] <strong>Nathan Wrigley:</strong> So from what I&#8217;ve seen, it looks like a really simple solution to implement. What I mean by that is, as a user of your product, it seems like you&#8217;re basically doing a bunch of stuff which as a WordPress user you would be simply doing anyway.</p>



<p class="wp-block-paragraph">Like, you create a post. I don&#8217;t know if there&#8217;s a requirement to have a special custom post type for a podcast, or if you can just use regular posts. You go in, drop some audio in, and kind of you&#8217;re off to the races. Type some text and what have you.</p>



<p class="wp-block-paragraph">Is it really as simple as that? Is it simply a case of make a post, drop some audio in? Or is there some stuff that you need to do in advance to prepare your podcast? So I&#8217;m leading you up the garden path with that question. Tell us how it works. What do you need to do in order to get started? How much work is involved?</p>



<p class="wp-block-paragraph">[00:13:59] <strong>Tony:</strong> Yeah, I think that&#8217;s it. There are a few settings that are naturally required for starting a show. So you have your typical art for your show. You&#8217;ve got to set your categories and things like that in a setting. But then once that&#8217;s all set up, all you do is you create a new post, drop in the audio. We actually have an audio block as well, like a podcast episode block that will pull in a lot of the newer, fancier, podcasting 2.0 markup as well for you to do like chapters and things like that. And then that&#8217;s it.</p>



<p class="wp-block-paragraph">As long as it&#8217;s within the category, it&#8217;s not a custom post type, it&#8217;s just a regular post. And then we are able to differentiate between an episode and just a post by two things. One, is it in the designated category that you set? And two, does it have the audio or video? We also have a few video files that we allow as well, and that&#8217;s it.</p>



<p class="wp-block-paragraph">[00:14:46] <strong>Nathan Wrigley:</strong> Okay, that&#8217;s really neat. So you can use a regular WordPress post, but if you don&#8217;t assign it the category, let&#8217;s say in this case I&#8217;ve named it podcast, let&#8217;s go with that. If you don&#8217;t assign that category, it&#8217;s a regular post. Nothing off that tries to smuggle its way into your RSS feed, which would be attempted to be consumed by a podcast player. It just doesn&#8217;t go in there.</p>



<p class="wp-block-paragraph">The minute I assign the category of podcast, drop in some audio, then it&#8217;s in that separate RSS feed. Dear listener, if you&#8217;re not familiar with that, basically a podcast is an RSS feed. That is literally what it is. Your podcast player is just consuming a bunch of text, which is an RSS feed, and interpreting that in a certain way with images and the audio and what have you.</p>



<p class="wp-block-paragraph">And so that&#8217;s it. That&#8217;s all you have to do. Configure the settings, put a piece of audio in, assign the category, click publish. You&#8217;re done.</p>



<p class="wp-block-paragraph">[00:15:35] <strong>Tony:</strong> Yep, that&#8217;s all. That&#8217;s all it is. I think the harder part is trying to come up with the titles and filling out the show notes. And, I have a friend who I got to start a podcast when we were working on this product, and he was using it, giving us feedback. But then, it&#8217;s like I looked at his podcast, and it was literally just like episode one, and it just, he&#8217;s like, &#8220;That&#8217;s the hard part, is coming up with all of the other stuff.&#8221;</p>



<p class="wp-block-paragraph">[00:15:53] <strong>Nathan Wrigley:</strong> But you have Jetpack AI as well, don&#8217;t you? So there is an opportunity, I would presume, to lean into that. If you were to write a corpus of text that went alongside the, I don&#8217;t know, the audio, it could be a transcript or what have you. Presumably then Jetpack can go sift through all of that, and suggest some sensible titles if you really can&#8217;t be bothered to work out a title for the podcast episode. But then again, does it have the capacity to do things like trawl through the audio and transcribe and things like that? Or is that a bit roadmap-y still?</p>



<p class="wp-block-paragraph">[00:16:20] <strong>Tony:</strong> Yeah. So that was one of the things that we wanted to work on was the ability to transcribe. And, because we have the privilege of working closely with Pocket Casts, we have, a lot of fancy tools that they have built already for their podcasting platform that we were going to try and leverage for the podcast show.</p>



<p class="wp-block-paragraph">[00:16:39] <strong>Nathan Wrigley:</strong> Pocket Casts is an Android, iOS, and, it&#8217;s a web player as well. It&#8217;s a place where you go download onto your phone or what have you and play them. I have it, I use it every single week, and I&#8217;ve noticed that whether a transcript is made or not, Pocket Casts actually makes one.</p>



<p class="wp-block-paragraph">[00:16:54] <strong>Tony:</strong> Yep.</p>



<p class="wp-block-paragraph">[00:16:54] <strong>Nathan Wrigley:</strong> So if I ship a podcast without a transcript, Pocket Casts magically has a transcript. So I don&#8217;t know where that voodoo is happening. But that technology, you can then do double duty on that. You can take the technology they&#8217;ve built, use it in the Jetpack side of things, and do the transcription. Okay, that&#8217;s neat. Sorry, I interrupted. Apologies.</p>



<p class="wp-block-paragraph">[00:17:11] <strong>Tony:</strong> You&#8217;re good. Yeah, that&#8217;s all of it. That&#8217;s, it right there.</p>



<p class="wp-block-paragraph">[00:17:13] <strong>Rob Pugh:</strong> I think that&#8217;s a great segue into Pocket Casts, which in our opinion is the best app to listen to podcasts. The best platform. And one of the really cool things we were able to do with, because we work closely with Pocket Casts, is when you are distributing your podcast. We pick, just to start, the six biggest ones and hold your hand on submitting to them. But Pocket Casts is actually Automattic. Automattic, you can spell it with one or two Ts. And, if you click the button, it just is uploaded to their network It takes minutes, and it&#8217;s, some of the other ones, we hold your hand, but it&#8217;s a little annoying, and some of them can take a couple days, like Apple, to approve things. But, Pocket Casts just works. I don&#8217;t know if you want to add anything on that magic, Tony.</p>



<p class="wp-block-paragraph">[00:17:52] <strong>Tony:</strong> Yeah, it&#8217;s very simple. It&#8217;s like right off the bat. If you already had an episode recorded, you could start a new website, upload your first episode, set your settings, and be on Pocket Casts, I would say, in less than an hour, honestly.</p>



<p class="wp-block-paragraph">[00:18:06] <strong>Nathan Wrigley:</strong> Yeah, because you&#8217;ve got that tight integration.</p>



<p class="wp-block-paragraph">[00:18:08] <strong>Tony:</strong> Yeah. It doesn&#8217;t say anything for the website configurations, which I&#8217;m sure would take more time, but at the very least, if you wanted to get your show out there, it&#8217;s a pretty instant approval.</p>



<p class="wp-block-paragraph">[00:18:17] <strong>Nathan Wrigley:</strong> I think podcast players. If you&#8217;ve never run a podcast, there&#8217;s this whole dance that you have to do. The first time you ever try to release an episode, and that is to get it set up with the distribution channels that are popular. So I&#8217;m thinking of things like Apple Podcasts, and YouTube Music, and Amazon, and the list goes on and on. There&#8217;s, dozens of them, some more important than others. I think probably Apple is probably the biggest one, and maybe Spotify and some others come in second and third place.</p>



<p class="wp-block-paragraph">But you have to do this thing where in some cases you have to go and get an account, and there&#8217;s really no way around that. Do you do some of that heavy lifting though? Do you make it easy for people to understand how to do it? When I did it, like 10 years ago for the first, and thankfully, only time I really ever had to do it, it was a case of going out and Googling it and reading things. But do you have that information in the UI to make that journey a little bit easier, reduce hours to minutes perhaps?</p>



<p class="wp-block-paragraph">[00:19:07] <strong>Tony:</strong> Yep, we have a button.</p>



<p class="wp-block-paragraph">[00:19:08] <strong>Rob Pugh:</strong> So there&#8217;s a distribution tab which lists the, all six like you mentioned, Amazon, Spotify, Apple, Pocket Casts, Podcast Index, which covers a whole bunch of minor networks. And I&#8217;d love to one day have it be fully automatic like it is with Pocket Casts. But some of them you need actual partnerships with these, Apple or Spotify to make that happen, and we haven&#8217;t prioritized putting a business person to go start a relationship and that.</p>



<p class="wp-block-paragraph">So we will organize them for you and try and give clear instructions in our documentation to how to do it. But there is just a button then when you&#8217;re looking and it shows you the status of it, if it&#8217;s in or not.</p>



<p class="wp-block-paragraph">[00:19:42] <strong>Nathan Wrigley:</strong> Okay. So you click the button, do the necessary thing, and then it will report back to you whether or not that has been successful. It&#8217;s a bit of a strange vestige really of the internet from way back when. It feels like in this day and age of everybody using APIs to connect to this, that, and the other thing.</p>



<p class="wp-block-paragraph">But companies like Apple seem to be very unwilling to let that bit of their system be wide open. You&#8217;ve got to sign up for an Apple Creators account. I forget exactly what it&#8217;s called, but you log in and then you submit your RSS feed. It really doesn&#8217;t take that long, but you still have to do it.</p>



<p class="wp-block-paragraph">[00:20:12] <strong>Rob Pugh:</strong> Yeah.</p>



<p class="wp-block-paragraph">[00:20:13] <strong>Nathan Wrigley:</strong> And I think they&#8217;re doing it because they get to see from the inside out, how popular your podcast is. And I don&#8217;t know, maybe they can monetize things from their end. I&#8217;m not really sure how that works.</p>



<p class="wp-block-paragraph">[00:20:23] <strong>Rob Pugh:</strong> It&#8217;s really another example of the closed internet.</p>



<p class="wp-block-paragraph">[00:20:26] <strong>Nathan Wrigley:</strong> Yeah.</p>



<p class="wp-block-paragraph">[00:20:26] <strong>Rob Pugh:</strong> Which is terrible. Why does Apple and Spotify need to be closed? So I think with having your podcast on WordPress with Jetpack, wordpress.com, and being in Pocket Casts, great. Then you&#8217;re, in the more of the open garden which is a better place to be.</p>



<p class="wp-block-paragraph">And the cool thing with our stats, you can see who&#8217;s coming, like how many people are listening to your show on Apple versus Spotify versus Pocket Casts. So you know if you&#8217;re not getting any from Spotify, then you don&#8217;t even need to be there. Of course though, it helps with findability to be everywhere, so we want to give you that option.</p>



<p class="wp-block-paragraph">[00:20:56] <strong>Nathan Wrigley:</strong> Yeah, at the end of the day, it all boils down to an RSS feed, which if it&#8217;s on your WordPress website presumably contains your domain name, forward slash, I don&#8217;t know, feed forward slash something maybe. So your RSS feed is going to be fairly short, probably very on message.</p>



<p class="wp-block-paragraph">Does it work that way or does it have some sort of Jetpack or, I don&#8217;t know, WordPress.com thing in it? Because when you go to these other platforms, it&#8217;s typically platformname.com/randomstringof12characters or something like that, which is very hard to read out in your podcast. But the way you&#8217;ve got it built, it sounds like the sort of thing that would trip off the tongue. So you know, wptavern.com/podcast. Put that into your podcast player of choice and you&#8217;re done. I&#8217;m saying all of that like that&#8217;s true, but I don&#8217;t know if it is.</p>



<p class="wp-block-paragraph">[00:21:40] <strong>Tony:</strong> Yeah, that&#8217;s it. Slash feed at the end.</p>



<p class="wp-block-paragraph">[00:21:43] <strong>Nathan Wrigley:</strong> Okay.</p>



<p class="wp-block-paragraph">[00:21:43] <strong>Tony:</strong> Because it is an RSS feed, yeah.</p>



<p class="wp-block-paragraph">[00:21:45] <strong>Nathan Wrigley:</strong> That&#8217;s still fairly straightforward. But again, that&#8217;s a nice bit of branding, isn&#8217;t it? And, I think that&#8217;s really good.</p>



<p class="wp-block-paragraph">Linking it back to the branding. We touched on this a minute ago, but if you haven&#8217;t started a podcast before, it may not be entirely obvious that you do want those other things like a newsletter, and like the ability to post to socials, and it feels like you&#8217;ve got the complete wraparound solution for that.</p>



<p class="wp-block-paragraph">Because as your podcast grows, which let&#8217;s hope it does, then you will probably wish to have a relationship with your listeners via an email newsletter. You probably will wish to be posting on social media. You probably will wish to do all of these different things. So social posting, newsletter, RSS feed, WordPress as the sort of custodian of all the text and the images and the videos that I put in. Is there any other secret sauce that we&#8217;ve missed there? Is there any other sort of unique binding that Jetpack brings that we haven&#8217;t mentioned there?</p>



<p class="wp-block-paragraph">[00:22:37] <strong>Rob Pugh:</strong> I&#8217;ll take it back first to like why we started this, and decided to build this, and I think you&#8217;re exactly right. First we found there are lots of WordPress.com and Jetpack users who have podcasts somewhere else. And that&#8217;s fine, but they were forced to because we didn&#8217;t offer it, and that really makes sense. Why would you need to go somewhere else?</p>



<p class="wp-block-paragraph">So you say today, our goal in creating it was twofold for the people creating the platform. It should just be as easy as possible. Podcasting and writing is hard enough. You should focus on that. Let us handle all the difficult stuff.</p>



<p class="wp-block-paragraph">Like you said, you need to, have a newsletter and a podcast and a blog and own all of it, and why can&#8217;t you do that with one publish event? And then from the consumer&#8217;s side of like consumer of content, some people want to listen to only podcasts, and some people want to read on a blog or, say, the WordPress.com reader. Shout out, go check that out if you haven&#8217;t in a while.</p>



<p class="wp-block-paragraph">And like me, I prefer to actually read stuff in my email inbox, like a old weirdo. It shouldn&#8217;t be, you should let people consume however they want to, and it shouldn&#8217;t be a lot of extra work for you, the host, the creator, to manage all of these things on different platforms. Just have it be as simple as possible, and that was really our goal. And then, yes, exactly what you said with all the other Jetpack stuff. Social media is a great one. Gosh, you could go on and on. Performance, security, basics.</p>



<p class="wp-block-paragraph">[00:23:46] <strong>Nathan Wrigley:</strong> Yeah. And it binds to, you said it just then, and it binds to the one publish event. So when I began my podcasting journey you end up with, like all these Zapier connections and different ways that, I don&#8217;t know, a webhook which goes off here and does a particular thing because you want it to be posted to this social network. With this, once you&#8217;ve got all of the bits and pieces configured, you click publish.</p>



<p class="wp-block-paragraph">So you know, you do your audio, you write your text, you do all of that in a draft state, upload the audio. But the moment you click publish, the newsletter goes out, the social media posts go out, and all of that just happens automatically. And you don&#8217;t have to think about it. And they&#8217;re already there in your website.</p>



<p class="wp-block-paragraph">It&#8217;s not like you have to do much. You just toggle, actually we should talk about that. You have to toggle the Jetpack podcast setting on, and presumably the newsletter setting, and yada yada, all those other things. But once you&#8217;ve toggled all those things on and got them set up, every time you click publish, all of those dominoes fall, and everything just happens on autopilot, which is really nice.</p>



<p class="wp-block-paragraph">What do we need to toggle on? How do we set it up? How expensive is it? Let&#8217;s start there.</p>



<p class="wp-block-paragraph">[00:24:50] <strong>Rob Pugh:</strong> I&#8217;ll talk about the pricing and then Tony can talk about the, the toggles.</p>



<p class="wp-block-paragraph">[00:24:54] <strong>Nathan Wrigley:</strong> Excellent. Yeah.</p>



<p class="wp-block-paragraph">[00:24:55] <strong>Rob Pugh:</strong> Yeah, we talked a bit about the pricing. I think that Automattic has always had a really generous free tier across its products, and it made sense for us to continue that. So you can today go to WordPress.com and start a blog for free.</p>



<p class="wp-block-paragraph">It&#8217;s going to have some ads on it, but it&#8217;s free. You can have your newsletter sent out unlimited sends for free with unlimited subscribers, and unlimited podcasts for free. That&#8217;s like, amazing deal. We don&#8217;t get enough credit for that, but cool.</p>



<p class="wp-block-paragraph">But we did build some compelling things to make you hopefully want to upgrade, or as you grow your podcast, you&#8217;ll find valuable. I think the stats are really cool. To me, all of the essential stats and none of the unessential stats, which if you&#8217;re an advanced podcaster might not be as good as you&#8217;re looking for. But, for most novice users, you just want to know the basics.</p>



<p class="wp-block-paragraph">Anything beyond that starts to feel like Google Analytics, like, I&#8217;m lost. So just give me the basic. Are they coming on Apple? Where, how many listeners to which episodes, and where in the world are they coming from? Which refers, like which sites are they coming from? That&#8217;s a great starting place for me.</p>



<p class="wp-block-paragraph">Help with distribution, the episode list, having a clear place for all your podcast episodes, the podcast block, really cool. And on WordPress.com too, we include the audio hosting once you upgrade. It&#8217;s not on Jetpack yet, so we&#8217;re waiting to see if, because we offer a similar thing for VideoPress, shout out best video hosting for WordPress.</p>



<p class="wp-block-paragraph">[00:26:09] <strong>Nathan Wrigley:</strong> Yeah, there&#8217;s VideoPress will handle the video side of things. That&#8217;s becoming the thing, by the way. I&#8217;m sure you know that. But in the podcasting space, I went to The Podcast Show in London, about four months ago or something like that. Everybody&#8217;s talking about video.</p>



<p class="wp-block-paragraph">[00:26:22] <strong>Rob Pugh:</strong> Yeah.</p>



<p class="wp-block-paragraph">[00:26:23] <strong>Nathan Wrigley:</strong> And so that being bound into Jetpack as well is just another string to your bow. I&#8217;m just going to segue slightly. I think Pocket Cast does a pretty good job of doing things like HLS video. I could be wrong about that, but I&#8217;ve got a feeling it does.</p>



<p class="wp-block-paragraph">[00:26:35] <strong>Rob Pugh:</strong> They even hook up with your Apple TV now, so you can watch and listen and yeah.</p>



<p class="wp-block-paragraph">[00:26:40] <strong>Nathan Wrigley:</strong> Oh, so this is really clever and completely out of the realms of possibility just a year ago. So you could be listening on your headphones whilst you&#8217;re out walking the dog on your podcast player, so you&#8217;re only listening to audio. And you come back in, put your Apple TV on, turn on the Pocket Cast player, and it will seamlessly drop you right in the video at the exact moment where you finished the dog walk. It&#8217;s so clever and so neat. I love all that stuff.</p>



<p class="wp-block-paragraph">[00:27:08] <strong>Rob Pugh:</strong> The future is so cool.</p>



<p class="wp-block-paragraph">[00:27:09] <strong>Nathan Wrigley:</strong> Yeah.</p>



<p class="wp-block-paragraph">[00:27:10] <strong>Rob Pugh:</strong> I love it.</p>



<p class="wp-block-paragraph">[00:27:10] <strong>Nathan Wrigley:</strong> Okay. So Tony, how do we switch it on? Is it genuinely one toggle in the Jetpack settings, or is there a little bit more to be set up?</p>



<p class="wp-block-paragraph">[00:27:17] <strong>Tony:</strong> Yeah, more or less. There is one toggle to turn the module on. And then once it&#8217;s on, you go to Jetpack and click on the podcast option, and then from there, there should just be one button that is to set up your show.</p>



<p class="wp-block-paragraph">And all it really requires is you either creating a new category or selecting a category. And this is, as we were talking about before, the category feed that is going to be taken over from there. And then you technically are done. But it&#8217;s advised that you fill out all of the other base settings, and we walk you through all of the ones that are required by the podcast show apps, to make sure that you don&#8217;t get blocked by Apple or Spotify for not having the necessary settings.</p>



<p class="wp-block-paragraph">[00:27:57] <strong>Nathan Wrigley:</strong> If I&#8217;ve been a podcaster for a number of years and I&#8217;ve got, I don&#8217;t know, a back catalog of 100 episodes or something like that. How do we handle that? How do we bring in previous episodes? And is there like an automated way of doing that or do I have to go and refigure 100 brand new pages on my WordPress website?</p>



<p class="wp-block-paragraph">Is there any heavy lifting done there? Let&#8217;s just deal with the audio first, just the RSS feed and the audio. Is it a simple case of dropping the old podcast RSS feed in and you&#8217;ll capture all that audio and it&#8217;ll be on the Jetpack side of things? Let&#8217;s do that first.</p>



<p class="wp-block-paragraph">[00:28:28] <strong>Tony:</strong> That&#8217;s a great question. I am not super familiar with the Core WordPress importer, but I believe that if there is a valid RSS feed with the normal RSS style tags, like enclosure and things like that, you should be able to import your RSS feed. Depending on how it&#8217;s configured on your current host, directly into WordPress. I&#8217;m not too sure what that would result in exactly. Especially because there&#8217;s a lot of different hosts out there, and it&#8217;s not like there&#8217;s one standard format for exporting your content. But yeah, that should get you part of the way there.</p>



<p class="wp-block-paragraph">Then I think in the future, we&#8217;re really looking to start targeting some of the major current podcast hosts to be able to configure a migration flow to be able to come from those places to ours, in a more seamless way, albeit whatever sort of export they can give you or, whatnot. But I think that&#8217;s still on the horizon.</p>



<p class="wp-block-paragraph">[00:29:27] <strong>Nathan Wrigley:</strong> Yeah, it&#8217;d be really nice to, let&#8217;s say I have 100 episodes and I&#8217;ve got, it&#8217;s over on whatever, hosting platform X over there, for my podcast audio feed. It&#8217;d be nice to be able to just suck in all the descriptions, and all the titles and have them be created as WordPress posts with the category assigned. So that essentially my WordPress site with the click of a button and the wait of an hour has suddenly got 100 posts of the podcast type all ready to go. And then, that&#8217;ll sit inside my SEO sitemap and all of that kind of stuff. That would be really interesting to be able to do, I think.</p>



<p class="wp-block-paragraph">[00:29:58] <strong>Rob Pugh:</strong> Yeah, I think we will try and have that in the future. We usually do try and make importing, especially from closed platforms, super easy. An example, another Substack. We have an amazing Substack importer. They&#8217;re not a big podcaster yet, but they, do have some, and we can look at adding that. But if you have all of your newsletter on Substack, you click a button and we bring over your whole, build you a website, bring over all your posts, all your subscribers, even paid subscribers. We seamlessly transfer it to the Stripe account. Everything we&#8217;re building, we&#8217;re just trying to make it super easy for people to own your data, go wherever you want. We encourage movement in and out, wherever you want to go, it&#8217;s up to you.</p>



<p class="wp-block-paragraph">[00:30:31] <strong>Nathan Wrigley:</strong> I suppose that then leads me to this question, which is, and you&#8217;ve probably just answered it. You&#8217;re not holding people behind some sort of paywall here. If people try Jetpack Podcasts out and they decide, &#8220;You know what? I really want to go the other direction. I want to maybe go back to where I was, or just move to a new host,&#8221; or what have you. You&#8217;re not holding any of that hostage, are you? You can take it and run with it and put it somewhere else?</p>



<p class="wp-block-paragraph">[00:30:52] <strong>Rob Pugh:</strong> Yeah. Yeah, absolutely not. Like that&#8217;s the, I think, one of the fundamentals of WordPress. You should be able to move within WordPress and out as much as you want. I will say that this is a new feature that me and Tony have built. Just because something doesn&#8217;t exist in a super streamlined way, doesn&#8217;t mean it&#8217;s our intention to lock you in. So please reach out and we&#8217;ll happily help you migrate off if that&#8217;s your wish.</p>



<p class="wp-block-paragraph">[00:31:15] <strong>Nathan Wrigley:</strong> So I&#8217;ll just let you know, dear listener, that there&#8217;s several URLs which rather than read them, because in many cases they can be quite long. But one of them, which is really easy for me to say, I might as well do that one, is wordpress.com/podcast. That&#8217;s probably the easiest one. Oh, and maybe this one as well, jetpack.com/support/jetpack-podcast. There&#8217;s several more.</p>



<p class="wp-block-paragraph">[00:31:38] <strong>Rob Pugh:</strong> Let me jump in. Let me sorry, Because as of two days ago, we now have jetpack.com/podcast.</p>



<p class="wp-block-paragraph">[00:31:45] <strong>Nathan Wrigley:</strong> Oh, okay. That&#8217;s way better.</p>



<p class="wp-block-paragraph">[00:31:46] <strong>Rob Pugh:</strong> We just relaunched the entire jetpack.com site, which is cool. You should go check it out. Yeah, so.</p>



<p class="wp-block-paragraph">[00:31:51] <strong>Nathan Wrigley:</strong> Again though, that, so what was that? Jetpack.com/podcast is kind of the home for all of those bits and pieces.</p>



<p class="wp-block-paragraph">[00:31:56] <strong>Rob Pugh:</strong> Yep, exactly.</p>



<p class="wp-block-paragraph">[00:31:57] <strong>Nathan Wrigley:</strong> In which case, go there. That&#8217;s where you&#8217;re going to find all of the bits and pieces and I presume, when things are, adapted and modified.</p>



<p class="wp-block-paragraph">[00:32:03] <strong>Rob Pugh:</strong> Yeah, the way to think about it&#8217;s still for some people confusing about Jetpack. So if you would like a website, the best WordPress hosting, then go to wordpress.com/podcast, and we&#8217;ll host your podcast for you. And if you want to host somewhere else, that&#8217;s great. Go host your WordPress site somewhere else, then go to jetpack.com/podcast and we&#8217;ll get you all set up as well.</p>



<p class="wp-block-paragraph">[00:32:23] <strong>Nathan Wrigley:</strong> In which case, I will say thank you Rob, and thank you, Tony. Thanks so much for chatting to me, both of you.</p>



<p class="wp-block-paragraph">[00:32:28] <strong>Rob Pugh:</strong> Yeah. Thank you Nathan.</p>



<p class="wp-block-paragraph">[00:32:28] <strong>Tony:</strong> Yep, thank you.</p>
</div></details>



<p class="wp-block-paragraph">On the podcast today we have <a href="https://profiles.wordpress.org/robertbpugh/">Rob Pugh</a> and <a href="https://profiles.wordpress.org/arcangelini/">Tony Arcangelini</a>.</p>



<p class="wp-block-paragraph">Rob and Tony are longstanding members of the Automattic team, with extensive backgrounds in marketing, product, and software development. They’ve spent years building tools for creators, writers, podcasters, and everyone in between, and are now fully immersed in WordPress’s evolving podcasting capabilities.</p>



<p class="wp-block-paragraph">If you’ve been looking for ways to run your podcast from your own WordPress site, this conversation is for you. Rob and Tony dive into the new Jetpack podcasting features and why they made the leap from WordPress.com’s basic audio offerings to a more robust, integrated solution within Jetpack. They talk about what makes WordPress and Jetpack such a powerful home for creators: the ability to bring your newsletter, blog, podcast, and all your content and communication under one roof, all while keeping ownership of your data.</p>



<p class="wp-block-paragraph">We talk through the advantages of keeping your content out of walled gardens like Substack and Patreon, and the value of flexibility, whether that’s adding WooCommerce to sell merch or customising your site’s look. Rob and Tony break down just how easy it is to start your show, drop audio into a post, set your category, and let Jetpack handle the rest, from distributing your RSS feed to major podcast apps, to sending out newsletters and automated social posts.</p>



<p class="wp-block-paragraph">They also get into how integrations with Pocket Casts and Jetpack AI make content creation, transcription, and distribution smoother than ever, plus how WordPress’ open foundation promises you’ll never be locked in.</p>



<p class="wp-block-paragraph">If you’re a creator wondering how the next generation of podcasting fits into the WordPress ecosystem, or just want an easier way to launch and grow your show, this episode is for you.</p>



<h2 class="wp-block-heading">Useful links</h2>



<p class="wp-block-paragraph"><a href="https://pocketcasts.com/">Pocket Casts</a></p>



<p class="wp-block-paragraph"><a href="https://videopress.com">VideoPress</a></p>



<p class="wp-block-paragraph"><a href="https://www.thepodcastshowlondon.com">The Podcast Show London</a></p>



<p class="wp-block-paragraph"><a href="https://wordpress.com/podcast/">Podcasts on wordpress.com</a></p>



<p class="wp-block-paragraph"><a href="https://jetpack.com/podcast/">Podcasts on jetpack.com</a></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 30 Sep 2026 12:00:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Nathan Wrigley";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:25;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:31:"bbPress: bbPress 2.6.19 is out!";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://bbpress.org/?p=249953";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:55:"https://bbpress.org/blog/2026/09/bbpress-2-6-19-is-out/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1642:"<p class="wp-block-paragraph">bbPress 2.6.19 is a security and maintenance release. Everyone running bbPress should update. <img alt="🔒" class="wp-smiley" src="https://s.w.org/images/core/emoji/17.0.2/72x72/1f512.png" style="height: 1em;" /></p>



<p class="wp-block-paragraph">This release applies inherited forum passwords to REST API responses and BuddyPress activity, and strengthens access checks for restricted forum content across feeds, group forums, and other indirect views. It also tightens moderation and forum-role permissions, protects importer credentials and account handling, and improves escaping in profile and administration output.</p>



<p class="wp-block-paragraph">There are maintenance fixes for BuddyPress group-forum associations and notifications, converter cleanup, imported database passwords, subscription emails, and reply positioning. The <a href="https://codex.bbpress.org/releases/bbpress-2-6-19/">2.6.19 upgrade notes</a> cover integration details. bbPress still requires WordPress 6.0 or newer and PHP 7.2 or newer. The automatic database version 264 upgrade clears saved converter query SQL from older password upgrades.</p>



<p class="wp-block-paragraph">These changes are also in the 2.7 development branch, which is now 2.7.0-alpha-4. Thank you to thewindghost, ngonhuy, and moltenbit for responsibly reporting issues fixed in this release, and to everyone who helped review and test the changes.</p>



<p class="wp-block-paragraph"><a href="https://downloads.wordpress.org/plugin/bbpress.2.6.19.zip">Download bbPress 2.6.19</a> from WordPress.org, or update from your WordPress dashboard.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 30 Sep 2026 01:17:13 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:17:"John James Jacoby";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:26;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:83:"Open Channels FM: Delegating to AI: What September Taught Us About Control and Cost";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2563114";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:89:"https://openchannels.fm/delegating-to-ai-what-september-taught-us-about-control-and-cost/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:149:"This month's AI stories, from kernel-crawling bots to assistants booking your flights, all pointed to the same gap: creation got cheap. Trust didn't.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 29 Sep 2026 12:12:01 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:16:"Open Channels FM";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:27;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:128:"HeroPress: From Blogging to Belonging: My WordPress Journey – Blogging से Belonging तक: मेरी WordPress Journey";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:56:"https://heropress.com/?post_type=heropress-essays&p=8892";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:168:"https://heropress.com/essays/from-blogging-to-belonging-my-wordpress-journey/#utm_source=rss&utm_medium=rss&utm_campaign=from-blogging-to-belonging-my-wordpress-journey";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:95629:"<img alt="Pull quote: From Blogging to Belonging: My WordPress Journey" class="attachment-large size-large wp-post-image" height="512" src="https://heropress.com/wp-content/uploads/3026/09/092826.webp" width="1024" /><p class="wp-block-paragraph"><a href="https://heropress.com/feed/#hindi">वर्डप्रेस ने मुझे मेरे ज़िंदगी में कुछ अलग करने का मौक़ा दिया।</a></p>



<h2 class="wp-block-heading" id="h-introduction"><strong>Introduction</strong></h2>



<p class="wp-block-paragraph">My name is <strong>Satyam Vishwakarma</strong>, though most people know me as <strong>Satya</strong>. </p>



<p class="wp-block-paragraph">I come from a small village called <strong>Mahmadpur</strong>, near <strong>Fatehpur, the city of Doaba</strong>, in Uttar Pradesh, nestled between the sacred <strong>Ganga</strong> and <strong>Yamuna</strong> rivers. <strong>This is the place I’ve always called home.</strong></p>



<p class="wp-block-paragraph">I studied <strong><em>Electronics Engineering (Micro)</em></strong> at <strong>Government Polytechnic College in Fatehpur</strong>. Growing up and studying in a relatively small city, I never had a clear idea of where technology or the internet could take me.</p>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/2026/09/image2.webp"><img alt="Satyam in the lunch line at WordCamp" class="wp-image-8893" height="732" src="https://heropress.com/wp-content/uploads/2026/09/image2-1024x732.webp" width="1024" /></a><figcaption class="wp-element-caption">Satyam Vishwakarma presenting his project during the first year of his diploma, 2018.</figcaption></figure>



<p class="wp-block-paragraph">I didn&#8217;t discover WordPress with a big career plan. I was simply curious about technology and wanted to help the people around me.</p>



<p class="wp-block-paragraph">Most of my classmates, including me, came from Hindi-medium schools or the UP Board. A lot of the technical material we found online was either difficult to understand or simply wasn&#8217;t written in the kind of simple English we were comfortable with.</p>



<p class="wp-block-paragraph">At the same time, I was probably one of the more tech-savvy people around me. I loved trying new software, exploring new features, and figuring out how things worked. Whenever I discovered something interesting, I would share it with my WhatsApp groups and classmates.</p>



<p class="wp-block-paragraph">I didn&#8217;t think of that as writing or teaching at the time.</p>



<p class="wp-block-paragraph">I was simply sharing something I had discovered.</p>



<p class="wp-block-paragraph">Eventually, I thought: why not put some of this information somewhere that more people could find it?</p>



<p class="wp-block-paragraph">That small thought became the beginning of my writing career.</p>



<h2 class="wp-block-heading" id="h-before-wordpress-there-was-blogger"><strong>Before WordPress, there was Blogger</strong></h2>



<p class="wp-block-paragraph">Some of my earliest opportunities to write online came through people I met on WhatsApp.</p>



<p class="wp-block-paragraph">I became friends with <strong>Mohit Vyas</strong> and <a href="https://www.linkedin.com/in/arpit-nuwal-19b634148/"><strong>Arpit Nuwal</strong></a> through one of the technology-focused WhatsApp groups I was part of. They had built a website called <strong>TopJankari</strong>. It wasn&#8217;t running on WordPress. It was a custom-built, dynamic website with its own basic way of managing content, but it was still fairly simple compared with the content management systems I discovered later.</p>



<p class="wp-block-paragraph">I started writing technology and tips-related content for TopJankari.</p>



<p class="wp-block-paragraph">For me, this was exciting. I was taking the things I was already experimenting with and turning them into something that other people could actually read and use.</p>



<p class="wp-block-paragraph">Around the same time, I started experimenting with Blogger.com and began publishing my own technology and tips-related content there.</p>



<p class="wp-block-paragraph">I wasn&#8217;t thinking about becoming a professional writer.</p>



<p class="wp-block-paragraph">I just enjoyed technology; I enjoyed explaining things, and I liked the idea that something I wrote could help another person solve a problem.</p>



<p class="wp-block-paragraph">That was enough motivation to keep going.</p>



<h2 class="wp-block-heading" id="h-then-wordpress-entered-the-picture"><strong>Then WordPress entered the picture</strong></h2>



<p class="wp-block-paragraph">While I was experimenting with blogging, my brother <a href="https://profiles.wordpress.org/shivamvishwakarma/"><strong>Shivam</strong></a> <em>(now runs a WordPress design agency called Subhash Digital)</em> built his first website with WordPress.</p>



<p class="wp-block-paragraph">That caught my attention.</p>



<p class="wp-block-paragraph">I was already curious about how websites worked, and seeing him build something with WordPress gave me an idea of what was possible. I wanted to try it myself.</p>



<p class="wp-block-paragraph">Around the same time, my brother <strong>Kapil</strong> and I started learning WordPress together.</p>



<p class="wp-block-paragraph">Neither of us really knew what we were doing.</p>



<p class="wp-block-paragraph">We learned through YouTube videos, documentation, blog posts, and mostly through experimentation.<br /><br />We would try something, break it, search for why it broke, fix it, and move on to the next thing.</p>



<p class="wp-block-paragraph">My first WordPress project was <strong>EngineersGuru</strong>, a place where I could share content related to my Electronics Engineering (Micro) course. </p>



<p class="wp-block-paragraph">I initially ran it as a subdomain, with the idea of making useful course-related tutorials and information easier for fellow students to understand.</p>



<p class="wp-block-paragraph">We also started an Android-related blog and Jankari.xyz, a more general website where I could write about pretty much anything I found interesting.</p>



<p class="wp-block-paragraph">In hindsight, those websites were my playground.</p>



<p class="wp-block-paragraph">They were where I learned WordPress, writing, SEO, content creation, and the basics of running websites.</p>



<p class="wp-block-paragraph">I wasn&#8217;t following a carefully designed career path. I was just building things because I wanted to see what I could do.</p>



<p class="wp-block-paragraph">And that curiosity kept taking me somewhere new.</p>



<h2 class="wp-block-heading" id="h-learning-by-failing"><strong>Learning by failing</strong></h2>



<p class="wp-block-paragraph">As I continued blogging, I started learning about SEO, monetization, and affiliate marketing.</p>



<p class="wp-block-paragraph">I experimented with different kinds of websites and eventually built more than ten blogs while I was still learning.</p>



<p class="wp-block-paragraph">One of my projects eventually became <strong>EYNZone</strong> <em>(formerly known as EYNWorld)</em>, where I started helping others learn WordPress and other skills and grow their own projects.</p>



<p class="wp-block-paragraph">There were plenty of failures along the way.</p>



<p class="wp-block-paragraph">I applied for Google AdSense more than twenty times before I finally stopped guessing and actually studied the guidelines carefully. Eventually, I got a brand-new domain approved with only two articles.</p>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/2026/09/image1.webp"><img alt="An Adsense panel showing success" class="wp-image-8894" height="521" src="https://heropress.com/wp-content/uploads/2026/09/image1-1024x521.webp" width="1024" /></a></figure>



<p class="wp-block-paragraph">That experience stayed with me.</p>



<p class="wp-block-paragraph">It taught me that rejection doesn&#8217;t necessarily mean you aren&#8217;t capable.</p>



<p class="wp-block-paragraph">Sometimes you simply haven&#8217;t figured out the problem yet.</p>



<p class="wp-block-paragraph">That became a recurring theme in my life.</p>



<h2 class="wp-block-heading" id="h-looking-for-a-career-finding-a-community"><strong>Looking for a career, finding a community</strong></h2>



<p class="wp-block-paragraph">Eventually, I started looking for a full-time job in mid 2022.</p>



<p class="wp-block-paragraph">That was another learning experience, although not always a pleasant one.</p>



<p class="wp-block-paragraph">I applied to more than 800 companies and went through around 2,000 job applications.</p>



<p class="wp-block-paragraph">During that period, I discovered <a href="https://www.underrepresentedintech.com/"><strong>UnderrepresentedInTech</strong></a> through <a href="https://profiles.wordpress.org/michelleames/"><strong>Michelle Frechette</strong></a><strong>.</strong> That eventually introduced me to <a href="https://poststatus.com/member-spotlight-satyam-vishwakarma/"><strong>Post Status</strong></a>, where I started meeting more people from the WordPress ecosystem.</p>



<p class="wp-block-paragraph">Something interesting was happening.</p>



<p class="wp-block-paragraph">While I was struggling to find where I fit professionally, I was slowly finding a place for myself in WordPress.</p>



<p class="wp-block-paragraph">I started learning not just about the software, but about the project behind it and the people who were building it.</p>



<p class="wp-block-paragraph">And then I heard about WordCamp Bhopal.</p>



<h2 class="wp-block-heading" id="h-the-wordcamp-i-almost-couldn-t-attend"><strong>The WordCamp I almost couldn&#8217;t attend</strong></h2>



<p class="wp-block-paragraph">My first WordCamp was WordCamp Bhopal in 2023.</p>



<p class="wp-block-paragraph">I wanted to go.</p>



<p class="wp-block-paragraph">I had told people I would go.</p>



<p class="wp-block-paragraph">There was just one problem: I didn&#8217;t have the money to actually make the trip happen.</p>



<p class="wp-block-paragraph">So I asked for help in the Post Status Slack community.</p>



<p class="wp-block-paragraph">I still think about what happened next.</p>



<p class="wp-block-paragraph">People who had never met me in person decided to help. <a href="https://profiles.wordpress.org/alanfuller/">Alan</a>, <a href="https://github.com/jennimckinnon">Jenni</a>, and <a href="https://profiles.wordpress.org/gelform/">Corey Maass</a> contributed financially. Michelle, <a href="https://profiles.wordpress.org/jeffr0/">Jeff</a>, and others shared my request, and <a href="https://profiles.wordpress.org/ronalfy/">Ronald</a> <em>(from DLXPlugins)</em> also helped after seeing it.</p>



<p class="wp-block-paragraph">People I barely knew, or had never met at all, helped me get to an event that I otherwise couldn&#8217;t have attended.</p>



<p class="wp-block-paragraph">I made it to Bhopal.</p>



<p class="wp-block-paragraph">The journey itself was almost comical. I travelled at the last moment, ended up at the wrong location at night, and then had an entire hotel saga before things finally settled down.</p>



<p class="wp-block-paragraph">But once I got there, none of that really mattered.</p>



<p class="wp-block-paragraph">Later at the event, <a href="https://www.linkedin.com/in/nabinjaiswal/">Nabin Jaiswal</a> also helped.</p>



<p class="wp-block-paragraph">I met people I had previously known only through websites, Slack, and social media.</p>



<figure class="wp-block-gallery has-nested-images columns-1 is-cropped wp-block-gallery-1 is-layout-flex wp-block-gallery-is-layout-flex">
<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/wcbhopal_2023_yash.webp"><img alt="" class="wp-image-8899" height="1024" src="https://heropress.com/wp-content/uploads/3026/09/wcbhopal_2023_yash.webp" width="717" /></a><figcaption class="wp-element-caption">With Yashwarshan Rana (one of the organizers at WCBhopal 2023)</figcaption></figure>



<figure class="wp-block-image size-full"><a href="https://heropress.com/wp-content/uploads/2026/09/image8-edited.webp"><img alt="WordCamp Bhopal attendees" class="wp-image-8870" height="699" src="https://heropress.com/wp-content/uploads/2026/09/image8-edited.webp" width="1600" /></a><figcaption class="wp-element-caption">WCBhopal 2023 group picture</figcaption></figure>
</figure>



<p class="wp-block-paragraph"><br />And then something unexpected happened.</p>



<p class="wp-block-paragraph">I wanted to go to another WordCamp.</p>



<p class="wp-block-paragraph">Then another.</p>



<p class="wp-block-paragraph">That first trip was followed by <strong>WordCamp Mumbai</strong>, <strong>WordCamp Udaipur,</strong> where <a href="https://udaipur.wordcamp.org/2023/puneet-sahalot-memorial-scholarship-winners/">I received a scholarship</a>, and <strong>WordCamp Ahmedabad</strong> in 2023.</p>



<figure class="wp-block-gallery has-nested-images columns-default is-cropped wp-block-gallery-2 is-layout-flex wp-block-gallery-is-layout-flex">
<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/wcmumbai_2023_with_vishal.webp"><img alt="" class="wp-image-8902" height="1024" src="https://heropress.com/wp-content/uploads/3026/09/wcmumbai_2023_with_vishal-1024x1024.webp" width="1024" /></a><figcaption class="wp-element-caption">With Vishal Mukadam at WCMumbai2023</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/with_aditya_sharma_at_wcahmeda_2023.webp"><img alt="" class="wp-image-8912" height="1024" src="https://heropress.com/wp-content/uploads/3026/09/with_aditya_sharma_at_wcahmeda_2023-768x1024.webp" width="768" /></a><figcaption class="wp-element-caption">With Aditya Sharma at WCAhemdabad2023</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/with_hitanshu_at_wcudaipur_2023.jpeg"><img alt="" class="wp-image-8905" height="1024" src="https://heropress.com/wp-content/uploads/3026/09/with_hitanshu_at_wcudaipur_2023-768x1024.jpeg" width="768" /></a><figcaption class="wp-element-caption">With Hitanshu at WCUdaipur2023</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/wcmumbai_2023_group_photo.webp"><img alt="" class="wp-image-8903" height="699" src="https://heropress.com/wp-content/uploads/3026/09/wcmumbai_2023_group_photo-1024x699.webp" width="1024" /></a><figcaption class="wp-element-caption">Group photo at WCMumbai 2023</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/wcah_2023_with_shoeb.webp"><img alt="" class="wp-image-8901" height="572" src="https://heropress.com/wp-content/uploads/3026/09/wcah_2023_with_shoeb-1024x572.webp" width="1024" /></a><figcaption class="wp-element-caption">With Shoeb and Elicus team at WCAhmedabad 2023</figcaption></figure>



<figure class="wp-block-image size-full"><a href="https://heropress.com/wp-content/uploads/3026/09/with_makarand_wcah_2023_temple.webp"><img alt="" class="wp-image-8900" height="408" src="https://heropress.com/wp-content/uploads/3026/09/with_makarand_wcah_2023_temple.webp" width="720" /></a><figcaption class="wp-element-caption">With Makarand Mane at a temple during WCAhmedabad 2023</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/satyam_with_taco_wcah2023.webp"><img alt="" class="wp-image-8904" height="768" src="https://heropress.com/wp-content/uploads/3026/09/satyam_with_taco_wcah2023-1024x768.webp" width="1024" /></a><figcaption class="wp-element-caption">With Taco at WCAhmedabad 2023</figcaption></figure>



<figure class="wp-block-image size-full"><a href="https://heropress.com/wp-content/uploads/3026/09/wcahemdabad_2023_with_new_community_friends.webp"><img alt="" class="wp-image-8911" height="686" src="https://heropress.com/wp-content/uploads/3026/09/wcahemdabad_2023_with_new_community_friends.webp" width="720" /></a><figcaption class="wp-element-caption">With Kuldeep, Kawaljeet, Divyang, and friends from StoreApps</figcaption></figure>
</figure>



<p class="wp-block-paragraph"><br />Within a few months, WordPress had gone from something I used on my computer to something I experienced through people.</p>



<p class="wp-block-paragraph">It had faces now.</p>



<p class="wp-block-paragraph">Names.</p>



<p class="wp-block-paragraph">Conversations.</p>



<p class="wp-block-paragraph">Handshakes.</p>



<p class="wp-block-paragraph">People asking how I was doing.</p>



<p class="wp-block-paragraph">And I wanted to give something back.</p>



<h2 class="wp-block-heading" id="h-i-didn-t-know-how-much-i-could-contribute"><strong>I didn&#8217;t know how much I could contribute</strong></h2>



<p class="wp-block-paragraph">I started with the Marketing team and gradually found my way into other parts of the project: Community, Meetups, Polyglots, Photos, Training, and Core.</p>



<p class="wp-block-paragraph">In January 2024, I published a public contribution goal for myself.</p>



<figure class="wp-block-embed is-type-rich is-provider-twitter wp-block-embed-twitter"><div class="wp-block-embed__wrapper">
<div class="embed-x"><blockquote class="twitter-tweet"><p dir="ltr" lang="en">My <a href="https://x.com/hashtag/WordPress?src=hash&amp;ref_src=twsrc%5Etfw">#WordPress</a> contribution goals for 2024:<br />1. Contribute 100 photos <img alt="📸" class="wp-smiley" src="https://s.w.org/images/core/emoji/17.0.2/72x72/1f4f8.png" style="height: 1em;" /><br />2. Translate 5000 strings <img alt="🌐" class="wp-smiley" src="https://s.w.org/images/core/emoji/17.0.2/72x72/1f310.png" style="height: 1em;" /><br />3. Write 5 documentation pieces <img alt="📝" class="wp-smiley" src="https://s.w.org/images/core/emoji/17.0.2/72x72/1f4dd.png" style="height: 1em;" /><br />4. Organize meetups <img alt="🤝" class="wp-smiley" src="https://s.w.org/images/core/emoji/17.0.2/72x72/1f91d.png" style="height: 1em;" /><br />5. Attend 8+ WordCamps <img alt="🎉" class="wp-smiley" src="https://s.w.org/images/core/emoji/17.0.2/72x72/1f389.png" style="height: 1em;" /><br />6. Make impactful marketing contributions! <img alt="💡" class="wp-smiley" src="https://s.w.org/images/core/emoji/17.0.2/72x72/1f4a1.png" style="height: 1em;" /> <a href="https://x.com/hashtag/OpenSource?src=hash&amp;ref_src=twsrc%5Etfw">#OpenSource</a> <a href="https://x.com/hashtag/WordPressCommunity?src=hash&amp;ref_src=twsrc%5Etfw">#WordPressCommunity</a> <a href="https://x.com/hashtag/2024Goals?src=hash&amp;ref_src=twsrc%5Etfw">#2024Goals</a> <a href="https://t.co/uLxE0BdYVL">pic.twitter.com/uLxE0BdYVL</a></p>&mdash; Satyam Vishwakarma (Satya) (@ask_hellosatya) <a href="https://x.com/ask_hellosatya/status/1747669657568571857?ref_src=twsrc%5Etfw">January 17, 2024</a></blockquote></div>
</div></figure>



<p class="wp-block-paragraph">I wanted to contribute 100 photos, translate thousands of strings, work on documentation and training, organize meetups, attend WordCamps, volunteer at events, and make meaningful contributions to marketing.</p>



<p class="wp-block-paragraph">At the time, it was simply a list of things I wanted to try.</p>



<p class="wp-block-paragraph">I didn&#8217;t know where it would lead.</p>



<p class="wp-block-paragraph">Within that year, I contributed around 150 photos and translated, reviewed, or suggested around 1,400 strings. I also reviewed Training content, organized my first meetup for WordPress&#8217;s 21st birthday, graduated as a mentee in the <a href="https://make.wordpress.org/community/2024/04/08/wordpress-contributor-mentorship-2024-q1-cohort-graduates/">WordPress Contributor Mentorship Program 2nd Cohort </a>for Support and Polyglots, worked on marketing for releases and events, volunteered at multiple events, and eventually led Contributor Day tables.</p>



<figure class="wp-block-gallery has-nested-images columns-default is-cropped wp-block-gallery-3 is-layout-flex wp-block-gallery-is-layout-flex">
<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/SKR.webp"><img alt="" class="wp-image-8919" height="785" src="https://heropress.com/wp-content/uploads/3026/09/SKR-1024x785.webp" width="1024" /></a><figcaption class="wp-element-caption">Volunteering at WCNagpur 2024</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/IMG_1972.webp"><img alt="" class="wp-image-8914" height="683" src="https://heropress.com/wp-content/uploads/3026/09/IMG_1972-1024x683.webp" width="1024" /></a><figcaption class="wp-element-caption">Group photo at WCBengaluru 2024</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/IMG_1609.webp"><img alt="" class="wp-image-8916" height="683" src="https://heropress.com/wp-content/uploads/3026/09/IMG_1609-1024x683.webp" width="1024" /></a><figcaption class="wp-element-caption">With community friends at WCBengaluru 2024</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/IMG_1535.webp"><img alt="" class="wp-image-8917" height="683" src="https://heropress.com/wp-content/uploads/3026/09/IMG_1535-1024x683.webp" width="1024" /></a><figcaption class="wp-element-caption">With Makarand and Malcure Security&#8217;s team at WCBengaluru 2024</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/IMG_9898.webp"><img alt="" class="wp-image-8913" height="683" src="https://heropress.com/wp-content/uploads/3026/09/IMG_9898-1024x683.webp" width="1024" /></a><figcaption class="wp-element-caption">Volunteering at WCKerala 2024</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/LOK_2760.webp"><img alt="" class="wp-image-8918" height="681" src="https://heropress.com/wp-content/uploads/3026/09/LOK_2760-1024x681.webp" width="1024" /></a><figcaption class="wp-element-caption">During table leading at WCdelhi 2024</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/IMG_0616.webp"><img alt="" class="wp-image-8915" height="683" src="https://heropress.com/wp-content/uploads/3026/09/IMG_0616-1024x683.webp" width="1024" /></a><figcaption class="wp-element-caption">Team behind WCDelhi 2024 (organizers &amp; volunteers)</figcaption></figure>
</figure>



<p class="wp-block-paragraph"><br />I also became a Project Manager at do_action Bhopal after starting there as a Content and Social Media Manager.</p>



<figure class="wp-block-gallery has-nested-images columns-2 is-cropped wp-block-gallery-4 is-layout-flex wp-block-gallery-is-layout-flex">
<figure class="wp-block-image size-full"><a href="https://heropress.com/wp-content/uploads/3026/09/WhatsApp-Image-2024-09-15-at-19.51.40-1.webp"><img alt="" class="wp-image-8908" height="2560" src="https://heropress.com/wp-content/uploads/3026/09/WhatsApp-Image-2024-09-15-at-19.51.40-1.webp" width="1441" /></a><figcaption class="wp-element-caption">With Yashwardhan at do_action Bhopal 2024</figcaption></figure>



<figure class="wp-block-image size-full"><a href="https://heropress.com/wp-content/uploads/3026/09/WhatsApp-Image-2024-09-15-at-19.51.40.webp"><img alt="" class="wp-image-8909" height="2560" src="https://heropress.com/wp-content/uploads/3026/09/WhatsApp-Image-2024-09-15-at-19.51.40.webp" width="1441" /></a><figcaption class="wp-element-caption">At do_action Bhopal 2024</figcaption></figure>



<figure class="wp-block-image size-full"><a href="https://heropress.com/wp-content/uploads/3026/09/WhatsApp-Image-2024-09-15-at-19.51.41-1.webp"><img alt="" class="wp-image-8910" height="960" src="https://heropress.com/wp-content/uploads/3026/09/WhatsApp-Image-2024-09-15-at-19.51.41-1.webp" width="1280" /></a><figcaption class="wp-element-caption">Building a website with the team at do_action Bhopal 2024</figcaption></figure>



<figure class="wp-block-image size-full"><a href="https://heropress.com/wp-content/uploads/3026/09/WhatsApp-Image-2024-09-15-at-19.51.39.webp"><img alt="" class="wp-image-8907" height="1564" src="https://heropress.com/wp-content/uploads/3026/09/WhatsApp-Image-2024-09-15-at-19.51.39.webp" width="2560" /></a><figcaption class="wp-element-caption">The website we built at do_action Bhopal 2024, along with my volunteer badge, lanyard, and token of appreciation.</figcaption></figure>



<figure class="wp-block-image size-full"><a href="https://heropress.com/wp-content/uploads/3026/09/WhatsApp-Image-2024-09-15-at-19.51.35.webp"><img alt="" class="wp-image-8906" height="960" src="https://heropress.com/wp-content/uploads/3026/09/WhatsApp-Image-2024-09-15-at-19.51.35.webp" width="1280" /></a><figcaption class="wp-element-caption">Group picture of do_action Bhopal 2024</figcaption></figure>
</figure>



<p class="wp-block-paragraph"><br />I also volunteered at <a href="https://phpcamp.org/phpcamp-2024/">PHPCamp 2024</a>, an Un(conference) inspired by the BarCamp format.</p>



<figure class="wp-block-gallery has-nested-images columns-default is-cropped wp-block-gallery-5 is-layout-flex wp-block-gallery-is-layout-flex">
<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/LOI_0272.webp"><img alt="" class="wp-image-8939" height="683" src="https://heropress.com/wp-content/uploads/3026/09/LOI_0272-1024x683.webp" width="1024" /></a><figcaption class="wp-element-caption">PHPCamp 2024 group photo</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/LOI_0281.webp"><img alt="" class="wp-image-8940" height="683" src="https://heropress.com/wp-content/uploads/3026/09/LOI_0281-1024x683.webp" width="1024" /></a><figcaption class="wp-element-caption">PHPCamp 2024 core team</figcaption></figure>
</figure>



<p class="wp-block-paragraph"><br />Other WordCamp Events I Attended in 2025–2026</p>



<figure class="wp-block-gallery has-nested-images columns-default is-cropped wp-block-gallery-6 is-layout-flex wp-block-gallery-is-layout-flex">
<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/LOK_3976.webp"><img alt="" class="wp-image-8921" height="681" src="https://heropress.com/wp-content/uploads/3026/09/LOK_3976-1024x681.webp" width="1024" /></a><figcaption class="wp-element-caption">Me with Vishal and Chetan during the Table Leads introduction at WCKolhapur 2025 Contributor Day</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/IMG_1379.webp"><img alt="" class="wp-image-8922" height="683" src="https://heropress.com/wp-content/uploads/3026/09/IMG_1379-1024x683.webp" width="1024" /></a><figcaption class="wp-element-caption">WCKolhapur 2025 volunteers</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/54379629689_16249134c8_o.webp"><img alt="" class="wp-image-8923" height="683" src="https://heropress.com/wp-content/uploads/3026/09/54379629689_16249134c8_o-1024x683.webp" width="1024" /></a><figcaption class="wp-element-caption">During the Table introduction at WCAsia 2025 &#8211; Contributor Day with Emma</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/54379596958_6887e5bee2_o.webp"><img alt="" class="wp-image-8925" height="684" src="https://heropress.com/wp-content/uploads/3026/09/54379596958_6887e5bee2_o-1024x684.webp" width="1024" /></a><figcaption class="wp-element-caption">WCAsia 2025: all the table leads on stage</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/54379837230_fbb7ed4ea9_o.webp"><img alt="" class="wp-image-8928" height="576" src="https://heropress.com/wp-content/uploads/3026/09/54379837230_fbb7ed4ea9_o-1024x576.webp" width="1024" /></a><figcaption class="wp-element-caption">Marketing Table at WCAsia 2025</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/IMG_2699.webp"><img alt="" class="wp-image-8924" height="576" src="https://heropress.com/wp-content/uploads/3026/09/IMG_2699-1024x576.webp" width="1024" /></a><figcaption class="wp-element-caption">Volunteers at WCAsia 2025 in Manila</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/54382855294_90a49b4e75_o.webp"><img alt="" class="wp-image-8926" height="683" src="https://heropress.com/wp-content/uploads/3026/09/54382855294_90a49b4e75_o-1024x683.webp" width="1024" /></a><figcaption class="wp-element-caption">India at WCAsia 2025</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/IMG_0704.webp"><img alt="" class="wp-image-8929" height="683" src="https://heropress.com/wp-content/uploads/3026/09/IMG_0704-1024x683.webp" width="1024" /></a><figcaption class="wp-element-caption">Attendee during WCBhopal 2025</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/JBS_6192.webp"><img alt="" class="wp-image-8927" height="684" src="https://heropress.com/wp-content/uploads/3026/09/JBS_6192-1024x684.webp" width="1024" /></a><figcaption class="wp-element-caption">WCKolhapur 2026 Organizers at WCBhopal 2025 stage</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/G_-nnUgWQAAABmB.webp"><img alt="" class="wp-image-8931" height="1024" src="https://heropress.com/wp-content/uploads/3026/09/G_-nnUgWQAAABmB-768x1024.webp" width="768" /></a><figcaption class="wp-element-caption">With Rohan from WPBakery at WCKolhapur 2026</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/MG_2949-1.webp"><img alt="" class="wp-image-8933" height="683" src="https://heropress.com/wp-content/uploads/3026/09/MG_2949-1-1024x683.webp" width="1024" /></a><figcaption class="wp-element-caption">WCKolhapur 2026 Organizer</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/DSC_3556.webp"><img alt="" class="wp-image-8930" height="683" src="https://heropress.com/wp-content/uploads/3026/09/DSC_3556-1024x683.webp" width="1024" /></a><figcaption class="wp-element-caption">Anand is presenting a token of appreciation for the organizing efforts at WordCamp Kolhapur 2026.</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/DSC_3575.webp"><img alt="" class="wp-image-8932" height="683" src="https://heropress.com/wp-content/uploads/3026/09/DSC_3575-1024x683.webp" width="1024" /></a><figcaption class="wp-element-caption">WCKolhapur 2026 organizers </figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/55251165393_16986898d8_o.webp"><img alt="" class="wp-image-8934" height="769" src="https://heropress.com/wp-content/uploads/3026/09/55251165393_16986898d8_o-1024x769.webp" width="1024" /></a><figcaption class="wp-element-caption">Media Partner at WCAsia 2026</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/55250042207_d89b25e39b_o.webp"><img alt="" class="wp-image-8935" height="683" src="https://heropress.com/wp-content/uploads/3026/09/55250042207_d89b25e39b_o-1024x683.webp" width="1024" /></a><figcaption class="wp-element-caption">Me at WCAsia 2026 stage</figcaption></figure>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/IMG_0225.webp"><img alt="" class="wp-image-8936" height="768" src="https://heropress.com/wp-content/uploads/3026/09/IMG_0225-1024x768.webp" width="1024" /></a><figcaption class="wp-element-caption">With Takayuko from Contact Form 7 at Kinsta dinner</figcaption></figure>
</figure>



<p class="wp-block-paragraph"><br />I also helped with sponsorships and the overall program progress of <strong><a href="https://www.youtube.com/playlist?list=PL4VyLH_W8pdubN_yMOBNBOGVLyc2vECtD">WPSimplified’s three-month live WordPress training program</a></strong>, led by Sunil Kumar Sharma, which ran from <strong>November 2025 to January 2026</strong>.</p>



<figure class="wp-block-image size-large"><a href="https://heropress.com/wp-content/uploads/3026/09/IMG_0793.webp"><img alt="" class="wp-image-8941" height="683" src="https://heropress.com/wp-content/uploads/3026/09/IMG_0793-1024x683.webp" width="1024" /></a><figcaption class="wp-element-caption">Satyam Vishwakarma, with WPSimplified swag presented in recognition of his organizing efforts.</figcaption></figure>



<p class="wp-block-paragraph">On paper, those things look like achievements.</p>



<p class="wp-block-paragraph">But that&#8217;s not how I remember them.</p>



<p class="wp-block-paragraph">I remember sitting in meetings, wondering whether my idea was good enough.</p>



<p class="wp-block-paragraph">I remember asking questions.</p>



<p class="wp-block-paragraph">I remember people patiently explaining things.</p>



<p class="wp-block-paragraph">I remember realizing that I could actually be useful.</p>



<p class="wp-block-paragraph">And I remember the feeling of seeing something I had worked on become part of something much bigger than me.</p>



<p class="wp-block-paragraph">That was when contribution started becoming less about “what can I get from WordPress?” and more about “what can I give back?”</p>



<h2 class="wp-block-heading" id="h-the-people-became-the-story"><strong>The people became the story</strong></h2>



<p class="wp-block-paragraph">The more I contributed, the more people I met.</p>



<p class="wp-block-paragraph">Some of them became friends.</p>



<p class="wp-block-paragraph">Some became mentors.</p>



<p class="wp-block-paragraph">Some simply inspired me by watching how they showed up for the community.</p>



<p class="wp-block-paragraph"><strong>Michelle Frechette</strong> has been one of those people for me. So have <a href="https://profiles.wordpress.org/topher1kenobe/">Topher DeRosia</a>, <a href="https://profiles.wordpress.org/peiraisotta/">Isotta Peira</a>, <a href="https://profiles.wordpress.org/jainnidhi/">Nidhi Jain</a>, <a href="https://profiles.wordpress.org/kafleg/">Ganga Kafle</a>, and many others.</p>



<p class="wp-block-paragraph">What I admire about people like them isn&#8217;t just what they have achieved.</p>



<p class="wp-block-paragraph">It&#8217;s the way they make other people feel that there is room for them, too.</p>



<p class="wp-block-paragraph">That matters when you&#8217;re coming from somewhere like Fatehpur and trying to find your place in a global community.</p>



<p class="wp-block-paragraph">You don&#8217;t always need someone to give you an opportunity.</p>



<p class="wp-block-paragraph">Sometimes you just need someone to make you believe that you are allowed to try.</p>



<p class="wp-block-paragraph">I&#8217;ve been fortunate to have people do that for me.</p>



<h2 class="wp-block-heading" id="h-from-contributing-to-building"><strong>From contributing to building</strong></h2>



<p class="wp-block-paragraph">By my second year, I started wanting to build things of my own within the WordPress ecosystem.</p>



<p class="wp-block-paragraph">I <a href="https://asia.wordcamp.org/2025/volunteers/">volunteered</a> and <a href="https://asia.wordcamp.org/2025/meet-our-contributor-day-table-leads/">led the marketing team</a> alongside Emma Young at <strong>WordCamp Asia 2025</strong> in Manila.</p>



<p class="wp-block-paragraph">I started building plugins of my own, with contributions and support from <a href="https://profiles.wordpress.org/hchouhan/">Harish</a>, <a href="https://profiles.wordpress.org/bhargavbhandari90/">Bhargav</a>, <a href="https://profiles.wordpress.org/mkrndmane/">Makarand Mane</a>, <a href="https://profiles.wordpress.org/phantomcluster/">Hitanshu Sahu</a>, and <a href="https://profiles.wordpress.org/sajidansari65/">Sajid Ansari</a>.</p>



<p class="wp-block-paragraph">The first was <a href="https://wordpress.org/plugins/quoteframeshare-blockquote-share-copy/">QuoteFrameShare</a>.</p>



<p class="wp-block-paragraph"><em>It lets people create and share customizable blockquotes in WordPress.</em></p>



<blockquote class="wp-block-quote is-layout-flow wp-block-quote-is-layout-flow">
<p class="wp-block-paragraph"><em>That project was particularly meaningful to me because writing and poetry have always been a part of who I am. Something that started with me writing technology tutorials for fellow engineering students had now come full circle into something I was building for writers, poets, and storytellers.</em></p>
</blockquote>



<p class="wp-block-paragraph">The second was <a href="https://wordpress.org/plugins/contributor-photo-gallery/">Contributor Photo Gallery</a>.</p>



<p class="wp-block-paragraph"><em>It helps WordPress contributors display their WordPress.org photo contributions as a portfolio without needing to write code.</em></p>



<blockquote class="wp-block-quote is-layout-flow wp-block-quote-is-layout-flow">
<p class="wp-block-paragraph"><em>That one came from another part of my journey: photography and the WordPress Photo Directory.</em></p>
</blockquote>



<p class="wp-block-paragraph">I liked that both projects solved relatively simple problems, but for communities and people I actually cared about.</p>



<p class="wp-block-paragraph">I wasn&#8217;t just building a plugin because I could.</p>



<p class="wp-block-paragraph">I was building something because I had an idea and thought it could be useful to someone else.</p>



<h2 class="wp-block-heading" id="h-not-everything-went-smoothly"><strong>Not everything went smoothly</strong></h2>



<p class="wp-block-paragraph"><a href="https://satyamvishwakarma.com/wordpress-contribution-journey-transparency/">My WordPress journey</a> hasn&#8217;t been a straight line upward.</p>



<p class="wp-block-paragraph">There was a period when I became so enthusiastic about contributing that I started trying to do everything.</p>



<p class="wp-block-paragraph">Every team.</p>



<p class="wp-block-paragraph">Every opportunity.</p>



<p class="wp-block-paragraph">Every event.</p>



<p class="wp-block-paragraph">Every possible contribution.</p>



<p class="wp-block-paragraph">I was so focused on proving that I could contribute that I wasn&#8217;t paying enough attention to everything else in my life.</p>



<p class="wp-block-paragraph">Eventually, I burned out.</p>



<p class="wp-block-paragraph">I also learned that community work has its own challenges. Not every experience was positive, and there were moments when I felt overlooked, misunderstood, or discouraged.</p>



<p class="wp-block-paragraph">Those experiences were difficult, but they also forced me to think about what I actually wanted from contribution.</p>



<p class="wp-block-paragraph">I realized that I didn&#8217;t want to spend my time trying to prove that I belonged.</p>



<p class="wp-block-paragraph">I wanted to contribute because I cared about the project and the people in it.</p>



<p class="wp-block-paragraph">That changed how I look at contribution today.</p>



<p class="wp-block-paragraph">I learned that I didn&#8217;t need to be everywhere, collect every badge, or chase the biggest contribution count to prove that I cared. </p>



<p class="wp-block-paragraph">I needed to find a way of contributing that I could actually sustain.</p>



<p class="wp-block-paragraph">I also realized I didn&#8217;t need to sacrifice my health, livelihood, or peace of mind to prove that I cared.</p>



<p class="wp-block-paragraph">If you have one hour a week, contribute that hour.</p>



<p class="wp-block-paragraph">If you have more time, great.</p>



<p class="wp-block-paragraph">But contribution should be sustainable.</p>



<h2 class="wp-block-heading" id="h-the-support-that-i-will-never-forget"><strong>The support that I will never forget</strong></h2>



<p class="wp-block-paragraph">One of the reasons I can talk about the difficult parts honestly is that the positive side of this community has been very real for me too.</p>



<p class="wp-block-paragraph">People have supported me in ways they didn&#8217;t have to.</p>



<p class="wp-block-paragraph">The help I received to attend my first WordCamp is one example.</p>



<p class="wp-block-paragraph"><a href="https://barn2.com/blog/author/katie/">Katie</a> at <strong>Barn2</strong> later sponsored a couple of my WordCamp trips through the company&#8217;s events budget. <strong>Makarand</strong> nominated me for the <a href="https://yoast.com/community/care-fund/recipients/satyam-vishwakarma/">Yoast Care Fund</a>, which I was fortunate enough to receive.</p>



<p class="wp-block-paragraph">The <strong>WP Open Community Collective</strong> also supported me through a <strong>Contributor Day Lead Sponsorship</strong> sponsored by <strong>GoDaddy</strong>.</p>



<p class="wp-block-paragraph">And there were people who helped in ways that weren&#8217;t financial at all.</p>



<p class="wp-block-paragraph">People gave me their time.</p>



<p class="wp-block-paragraph">They answered questions.</p>



<p class="wp-block-paragraph">They recommended me.</p>



<p class="wp-block-paragraph">They encouraged me when I was uncertain.</p>



<p class="wp-block-paragraph">Those things can be easy to overlook when you are talking about contribution numbers, but for me, they are the real story.</p>



<p class="wp-block-paragraph">Because behind every contribution is usually a person.</p>



<p class="wp-block-paragraph">And behind my contributions are a lot of people who helped me get there.</p>



<h2 class="wp-block-heading" id="h-what-wordpress-gave-me"><strong>What WordPress gave me</strong></h2>



<p class="wp-block-paragraph">When I look back at the person who started writing technology tutorials for fellow engineering students, I don&#8217;t think he would have imagined any of this.</p>



<p class="wp-block-paragraph">I didn&#8217;t have a conventional path into technology.</p>



<p class="wp-block-paragraph">I didn&#8217;t study computer science.</p>



<p class="wp-block-paragraph">I learned WordPress by building things, breaking things, and figuring them out.</p>



<p class="wp-block-paragraph">And somehow, that was enough to get started.</p>



<p class="wp-block-paragraph">WordPress helped me develop skills in technology, content, SEO, marketing, product building, and community.</p>



<p class="wp-block-paragraph">It gave me opportunities to work with people around the world.</p>



<p class="wp-block-paragraph">It took me to WordCamps that I once couldn&#8217;t afford to attend.</p>



<p class="wp-block-paragraph">It helped me build open-source products.</p>



<p class="wp-block-paragraph">But those aren&#8217;t the things I value most.</p>



<p class="wp-block-paragraph">The biggest thing WordPress gave me was people.</p>



<p class="wp-block-paragraph">That&#8217;s why the word ‘belonging’ feels more appropriate to me than ‘success.’</p>



<p class="wp-block-paragraph">I came to WordPress to build websites.</p>



<p class="wp-block-paragraph">Somewhere along the way, WordPress helped me build a community around me.</p>



<h2 class="wp-block-heading" id="h-i-am-still-figuring-it-out"><strong>I am still figuring it out</strong></h2>



<p class="wp-block-paragraph">I still don&#8217;t know exactly where WordPress will take me.</p>



<p class="wp-block-paragraph">I want to keep building products.</p>



<p class="wp-block-paragraph">I want to grow further in the marketing and product side of my career.</p>



<p class="wp-block-paragraph">I want to explore more around partnerships and community.</p>



<p class="wp-block-paragraph">And one day, I&#8217;d love to co-lead a WordPress release.</p>



<p class="wp-block-paragraph">But I don&#8217;t want to chase these things just for a title or a badge.</p>



<p class="wp-block-paragraph">I want to build things that are genuinely useful.</p>



<p class="wp-block-paragraph">I want to become better at what I do.</p>



<p class="wp-block-paragraph">I want to help people who are where I was a few years ago.</p>



<p class="wp-block-paragraph">And I want to be the kind of person who, when someone remembers their first steps into WordPress, they can say: “Satya helped me get started.”</p>



<p class="wp-block-paragraph">That would mean more to me than any badge.</p>



<p class="wp-block-paragraph">Because that&#8217;s what happened to me.</p>



<p class="wp-block-paragraph">People helped me get started.</p>



<p class="wp-block-paragraph">People made space for me.</p>



<p class="wp-block-paragraph">People encouraged me.</p>



<p class="wp-block-paragraph">People believed I could contribute before I was completely sure myself.</p>



<p class="wp-block-paragraph">So if someone reading this is just starting their WordPress journey, my advice is simple:</p>



<p class="wp-block-paragraph">Start small. Ask questions. Find something you enjoy. Contribute consistently, but within your capacity.</p>



<p class="wp-block-paragraph">You don&#8217;t need to have everything figured out before you begin.</p>



<p class="wp-block-paragraph">I certainly didn&#8217;t.</p>



<p class="wp-block-paragraph">I started writing because I wanted to make complicated things easier for my classmates.</p>



<p class="wp-block-paragraph">I started blogging because I was curious about technology.</p>



<p class="wp-block-paragraph">I started using WordPress because my brother showed me what was possible.</p>



<p class="wp-block-paragraph">I kept learning because there was always something new to discover.</p>



<p class="wp-block-paragraph">And eventually, I started contributing because I wanted to give something back.</p>



<p class="wp-block-paragraph">But somewhere along the way, something else happened.</p>



<p class="wp-block-paragraph">I found people.</p>



<p class="wp-block-paragraph">I found opportunities.</p>



<p class="wp-block-paragraph">I found a community.</p>



<p class="wp-block-paragraph">And I found a place where I could keep learning, contributing, and becoming a little better than I was before.</p>



<p class="wp-block-paragraph">I came to WordPress to build websites.</p>



<p class="wp-block-paragraph">Somewhere along the way, WordPress helped me build a community around me.</p>



<p class="wp-block-paragraph">And maybe that&#8217;s what this journey has really been about.</p>



<p class="wp-block-paragraph"><strong>From blogging to belonging.</strong></p>



<h1 class="wp-block-heading" id="hindi"><strong>Blogging से Belonging तक: मेरी WordPress Journey</strong></h1>



<h2 class="wp-block-heading" id="h-श-र-आत"><strong>शुरुआत</strong></h2>



<p class="wp-block-paragraph">मेरा नाम <strong>सत्यम विश्वकर्मा</strong> है, हालांकि ज़्यादातर लोग मुझे <strong>सत्या</strong> के नाम से जानते हैं। </p>



<p class="wp-block-paragraph">मैं <strong>महमदपुर</strong> नाम के एक छोटे से गाँव से आता हूँ, जो उत्तर प्रदेश के <strong>फतेहपुर, दोआब के शहर</strong>, के पास है और गंगा और यमुना नदियों के बीच बसा है। <strong>यह जगह हमेशा से मुझे अपना घर लगी है।</strong></p>



<p class="wp-block-paragraph">मैंने फतेहपुर के <strong>Government Polytechnic College</strong> से <strong>Electronics Engineering (Micro)</strong> की पढ़ाई की। एक छोटे शहर में बड़े होते और पढ़ते हुए मुझे कभी ठीक से अंदाज़ा नहीं था कि technology या internet मुझे कहाँ तक ले जा सकते हैं।</p>



<p class="wp-block-paragraph">मैं WordPress तक किसी बड़े career plan के साथ नहीं पहुँचा था। मैं बस technology को लेकर उत्सुक था और अपने आसपास के लोगों की मदद करना चाहता था।</p>



<p class="wp-block-paragraph">मेरे ज़्यादातर classmates, मेरी तरह, Hindi-medium schools या UP Board से पढ़े हुए थे। </p>



<p class="wp-block-paragraph">हमें इंटरनेट पर मिलने वाली बहुत-सी technical सामग्री या तो समझना मुश्किल होती थी या फिर वह उस तरह की आसान English में नहीं होती थी, जिसे हम सहजता से समझ सकें।</p>



<p class="wp-block-paragraph">साथ ही, मैं शायद अपने आसपास के लोगों में technology को लेकर थोड़ा ज़्यादा curious था। </p>



<p class="wp-block-paragraph">मुझे नया software आज़माना, नए features explore करना और यह समझना बहुत पसंद था कि चीज़ें कैसे काम करती हैं। </p>



<p class="wp-block-paragraph">जब भी मुझे कुछ interesting मिलता, मैं उसे अपने WhatsApp groups और classmates के साथ share करता था।</p>



<p class="wp-block-paragraph">उस समय मैंने इसे writing या teaching के तौर पर नहीं देखा था।</p>



<p class="wp-block-paragraph">मैं बस वही share कर रहा था जो मैंने खुद discover किया था।</p>



<p class="wp-block-paragraph">फिर एक दिन मन में आया: </p>



<p class="wp-block-paragraph"><strong>क्यों न इस information को कहीं ऐसी जगह रखा जाए, जहाँ इसे और लोग भी ढूँढ सकें?</strong></p>



<p class="wp-block-paragraph">वही छोटी-सी सोच मेरी writing journey की शुरुआत बन गई।</p>



<h2 class="wp-block-heading" id="h-wordpress-स-पहल-blogger-थ"><strong>WordPress से पहले Blogger था</strong></h2>



<p class="wp-block-paragraph"><br />Online लिखने के मेरे शुरुआती मौकों में से कुछ मुझे WhatsApp पर मिले लोगों की वजह से मिले।</p>



<p class="wp-block-paragraph">मैं technology से जुड़े एक WhatsApp group के ज़रिए <strong>Mohit Vyas</strong> और <strong>Arpit Nawal</strong> से online मिला। उन्होंने <strong>TopJankari</strong> नाम की website बनाई थी।</p>



<p class="wp-block-paragraph">वह WordPress पर नहीं चलती थी। वह एक custom-built, dynamic website थी, जिसमें content manage करने का अपना basic system था। बाद में मुझे जिन content management systems के बारे में पता चला, उनकी तुलना में वह काफी simple थी।</p>



<p class="wp-block-paragraph">मैंने TopJankari के लिए technology और tips से जुड़ा content लिखना शुरू किया।</p>



<p class="wp-block-paragraph">मेरे लिए यह बहुत exciting था।</p>



<p class="wp-block-paragraph">जिन चीज़ों को मैं खुद आज़मा रहा था, उन्हें मैं अब इस तरह लिख रहा था कि कोई दूसरा भी उन्हें पढ़कर इस्तेमाल कर सके।</p>



<p class="wp-block-paragraph">उसी दौरान मैंने <strong>Blogger.com</strong> के साथ भी experiment करना शुरू किया और वहाँ अपना technology और tips-related content publish करने लगा।</p>



<p class="wp-block-paragraph">उस समय मैं professional writer बनने के बारे में नहीं सोच रहा था।</p>



<p class="wp-block-paragraph">मुझे बस technology पसंद थी। मुझे चीज़ों को समझाना पसंद था। और मुझे यह विचार अच्छा लगता था कि मेरे द्वारा लिखी गई कोई चीज़ किसी दूसरे व्यक्ति की समस्या हल करने में मदद कर सकती है।</p>



<p class="wp-block-paragraph">मेरे लिए इतना ही काफी था आगे बढ़ते रहने के लिए।</p>



<h2 class="wp-block-heading" id="h-फ-र-wordpress-म-र-कह-न-म-आय"><strong>फिर WordPress मेरी कहानी में आया</strong></h2>



<p class="wp-block-paragraph"><br />जब मैं blogging के साथ experiment कर रहा था, मेरे भाई <strong>Shivam</strong> ने उस समय तक WordPress पर अपनी पहली website बना ली थी।</p>



<p class="wp-block-paragraph">इसने मेरा ध्यान खींचा।</p>



<p class="wp-block-paragraph">मैं पहले से ही websites के काम करने के तरीके को लेकर curious था।</p>



<p class="wp-block-paragraph">उनको WordPress के साथ कुछ बनाते हुए देखकर मुझे पहली बार अंदाज़ा हुआ कि इसके साथ क्या-क्या बनाया जा सकता है। </p>



<p class="wp-block-paragraph">मैं भी इसे आज़माना चाहता था।</p>



<p class="wp-block-paragraph">उसी दौरान मेरे भाई <strong>Kapil</strong> और मैंने साथ मिलकर WordPress सीखना शुरू किया।</p>



<p class="wp-block-paragraph">हम दोनों को वास्तव में कुछ खास पता नहीं था।</p>



<p class="wp-block-paragraph">हमने YouTube videos, documentation, blog posts और सबसे ज़्यादा experimentation के ज़रिए सीखा।</p>



<p class="wp-block-paragraph">हम कुछ try करते, उसे तोड़ देते, फिर search करते कि वह क्यों टूटा, उसे ठीक करते और फिर अगली चीज़ पर बढ़ जाते।</p>



<p class="wp-block-paragraph">मेरा पहला WordPress project <strong>EngineersGuru</strong> था। वहाँ मैं अपनी Electronics Engineering (Micro) की पढ़ाई से जुड़ा content शेयर (publish) करता था।</p>



<p class="wp-block-paragraph">शुरुआत में मैंने इसे एक subdomain के रूप में चलाया। मेरा उद्देश्य था कि मेरे fellow students के लिए course से जुड़ी tutorials और useful information को समझना थोड़ा आसान हो सके।</p>



<p class="wp-block-paragraph">हमने एक Android-related blog भी शुरू किया और <strong>Jankari.xyz</strong> भी, जो एक ऐसी general website थी जहाँ मैं लगभग किसी भी ऐसी चीज़ के बारे में लिख सकता था जो मुझे interesting लगती थी।</p>



<p class="wp-block-paragraph">आज पीछे मुड़कर देखता हूँ तो ये websites मेरे लिए एक playground थीं।</p>



<p class="wp-block-paragraph">यहीं मैंने WordPress, writing, SEO, content creation और websites चलाने की basic बातें सीखीं।</p>



<p class="wp-block-paragraph">मैं किसी carefully planned career path पर नहीं चल रहा था।</p>



<p class="wp-block-paragraph">मैं बस चीज़ें बना रहा था, क्योंकि मैं देखना चाहता था कि मैं क्या कर सकता हूँ।</p>



<p class="wp-block-paragraph">और मेरी वही curiosity मुझे लगातार कहीं न कहीं आगे ले जाती रही।</p>



<h2 class="wp-block-heading" id="h-गलत-य-स-स-खन"><strong>गलतियों से सीखना</strong></h2>



<p class="wp-block-paragraph"><br />जैसे-जैसे blogging आगे बढ़ी, मैंने SEO, monetization और affiliate marketing के बारे में सीखना शुरू किया।</p>



<p class="wp-block-paragraph">मैंने अलग-अलग तरह की websites के साथ experiment किया और सीखते-सीखते दस से ज़्यादा blogs बनाए।</p>



<p class="wp-block-paragraph">मेरे इन्हीं projects में से एक आगे चलकर <strong>EYNZone</strong> बना, जिसे पहले <strong>EYNWorld</strong> के नाम से जाना जाता था। वहाँ मैंने दूसरे लोगों को WordPress और दूसरी skills सीखाने और अपने projects को grow करने में मदद करना शुरू किया।</p>



<p class="wp-block-paragraph">इस रास्ते में बहुत सारी असफलताएँ भी आईं।</p>



<p class="wp-block-paragraph">मैंने Google AdSense के लिए बीस से ज़्यादा बार apply किया, और हर बार कुछ न कुछ गलत हो जाता था। आखिरकार मैंने सिर्फ अंदाज़ा लगाना बंद किया और guidelines को सही से पढ़ना और समझना शुरू किया।</p>



<p class="wp-block-paragraph">आखिर में एक बिल्कुल नए domain पर सिर्फ दो articles के साथ मेरा AdSense approve हो गया।</p>



<p class="wp-block-paragraph">उस अनुभव का असर मुझ पर रह गया।</p>



<p class="wp-block-paragraph">इसने मुझे सिखाया कि rejection का मतलब हमेशा यह नहीं होता कि आप capable नहीं हैं।</p>



<p class="wp-block-paragraph">कभी-कभी इसका मतलब सिर्फ इतना होता है कि आपने अभी तक समस्या को समझा नहीं है।</p>



<p class="wp-block-paragraph">मेरी ज़िंदगी में यह बात बार-बार सामने आती रही।</p>



<h2 class="wp-block-heading" id="h-career-क-तल-श-म-न-कल-थ-community-म-ल-गई"><strong>Career की तलाश में निकला था, Community मिल गई</strong></h2>



<p class="wp-block-paragraph"><br />आखिरकार, 2022 के बीच में मैंने full-time नौकरी की तलाश शुरू की।</p>



<p class="wp-block-paragraph">वह भी अपने आप में एक learning experience था, हालांकि हमेशा अच्छा नहीं था।</p>



<p class="wp-block-paragraph">मैंने 800 से ज़्यादा companies में apply किया और करीब 2,000 job applications के process से गुज़रा।</p>



<p class="wp-block-paragraph">इसी दौरान मुझे <strong>Michelle Frechette</strong> के ज़रिए <strong>UnderrepresentedInTech</strong> के बारे में पता चला। वहाँ से आगे मुझे <strong>Post Status</strong> से जुड़ने का मौका मिला, जहाँ मैंने WordPress ecosystem के और लोगों से मिलना शुरू किया।</p>



<p class="wp-block-paragraph">कुछ interesting हो रहा था।</p>



<p class="wp-block-paragraph">जहाँ मैं यह समझने की कोशिश कर रहा था कि professionally मेरी जगह कहाँ है, वहीं धीरे-धीरे WordPress में मुझे अपनी जगह मिल रही थी।</p>



<p class="wp-block-paragraph">मैं सिर्फ software के बारे में नहीं सीख रहा था।</p>



<p class="wp-block-paragraph">मैं उस project के बारे में सीख रहा था जो software के पीछे था, और उन लोगों के बारे में भी जो उसे बनाने में मदद कर रहे थे।</p>



<p class="wp-block-paragraph">और फिर मैंने <strong>WordCamp Bhopal</strong> के बारे में सुना।</p>



<h2 class="wp-block-heading" id="h-वह-wordcamp-ज-स-म-लगभग-attend-नह-कर-प-त"><strong>वह WordCamp जिसे मैं लगभग attend नहीं कर पाता</strong></h2>



<p class="wp-block-paragraph"><br />मेरा पहला WordCamp, <strong>WordCamp Bhopal 2023</strong> था।</p>



<p class="wp-block-paragraph">मैं जाना चाहता था।</p>



<p class="wp-block-paragraph">मैंने लोगों से कह भी दिया था कि मैं जाऊँगा।</p>



<p class="wp-block-paragraph">बस एक समस्या थी।</p>



<p class="wp-block-paragraph">मेरे पास उस trip के लिए पैसे नहीं थे।</p>



<p class="wp-block-paragraph">इसलिए मैंने Post Status Slack community में मदद माँगी।</p>



<p class="wp-block-paragraph">आज भी मैं सोचता हूँ कि उसके बाद क्या हुआ था।</p>



<p class="wp-block-paragraph">जिन लोगों ने मुझे कभी सामने से देखा तक नहीं था, उन्होंने मेरी मदद करने का फैसला किया।</p>



<p class="wp-block-paragraph"><strong>Alan, Jenni और Corey Maass</strong> ने financially मदद की। <strong>Michelle, Jeff</strong> और दूसरे लोगों ने मेरी request को share किया। <strong>Ronald</strong>, जो DLXPlugins से हैं, उन्होंने भी इसे देखकर मदद की।</p>



<p class="wp-block-paragraph">जिन लोगों को मैं मुश्किल से जानता था, या शायद कभी मिला ही नहीं था, उन्होंने मुझे उस event तक पहुँचने में मदद की जहाँ मैं अपने दम पर नहीं जा सकता था।</p>



<p class="wp-block-paragraph">मैं Bhopal पहुँच गया।</p>



<p class="wp-block-paragraph">और वह सफ़र अपने आप में काफ़ी उलझनों से भरा था।</p>



<p class="wp-block-paragraph">मैंने आखिरी समय में यात्रा शुरू की, रात में गलत जगह पहुँच गया और फिर होटल को लेकर एक अलग ही किस्सा शुरू हो गया। आखिरकार, किसी तरह सब ठीक हुआ।</p>



<p class="wp-block-paragraph">लेकिन जब मैं वहाँ पहुँच गया, तो इनमें से किसी चीज़ की उतनी importance नहीं रही।</p>



<p class="wp-block-paragraph">Event के दौरान <strong>Nabin Jaiswal</strong> ने भी मेरी मदद की।</p>



<p class="wp-block-paragraph">मैं उन लोगों से मिला जिन्हें अब तक सिर्फ websites, Email, Slack और social media के ज़रिए जानता था।</p>



<p class="wp-block-paragraph">और फिर कुछ unexpected हुआ।</p>



<p class="wp-block-paragraph">मेरा मन हुआ कि मैं एक और WordCamp में जाऊँ।</p>



<p class="wp-block-paragraph">फिर एक और।</p>



<p class="wp-block-paragraph">उस पहली trip के बाद WordCamp Mumbai, WordCamp Udaipur, जहाँ मुझे scholarship मिली, और WordCamp Ahmedabad आए।</p>



<p class="wp-block-paragraph">कुछ ही महीनों में WordPress मेरे लिए computer पर इस्तेमाल की जाने वाली किसी चीज़ से बदलकर लोगों के ज़रिए अनुभव की जाने वाली चीज़ बन गया था।</p>



<p class="wp-block-paragraph">अब उसके चेहरे थे।</p>



<p class="wp-block-paragraph">नाम थे।</p>



<p class="wp-block-paragraph">बातचीत थी।</p>



<p class="wp-block-paragraph">हाथ मिलाना था।</p>



<p class="wp-block-paragraph">लोग पूछते थे कि मैं कैसा हूँ।</p>



<p class="wp-block-paragraph">और मेरा मन हुआ कि अब मुझे भी कुछ वापस देना चाहिए।</p>



<h2 class="wp-block-heading" id="h-म-झ-नह-पत-थ-क-म-क-तन-contribute-कर-सकत-ह"><strong>मुझे नहीं पता था कि मैं कितना contribute कर सकता हूँ</strong></h2>



<p class="wp-block-paragraph"><br />मैंने शुरुआत Marketing team से की और धीरे-धीरे WordPress project के दूसरे हिस्सों तक पहुँचता गया: Community, Meetups, Polyglots, Photos, Training और Core।</p>



<p class="wp-block-paragraph">जनवरी 2024 में मैंने अपने लिए एक public contribution लक्ष्य बनाया।</p>



<p class="wp-block-paragraph">मैं 100 photos contribute करना चाहता था, हजारों strings translate करना चाहता था, documentation और training पर काम करना चाहता था, meetups organize करना चाहता था, WordCamps attend करना चाहता था, events में volunteer करना चाहता था और marketing में meaningful contributions देना चाहता था।</p>



<p class="wp-block-paragraph">उस समय यह बस उन चीज़ों की एक list थी जिन्हें मैं try करना चाहता था।</p>



<p class="wp-block-paragraph">मुझे नहीं पता था कि यह मुझे कहाँ ले जाएगी।</p>



<p class="wp-block-paragraph">उस साल मैंने करीब 150 photos contribute कीं और लगभग 1,400 strings को translate, review या suggest किया। मैंने Training content भी review किया, WordPress के 21st birthday के लिए अपना पहला meetup organize किया, releases और events के marketing पर काम किया, कई events में volunteer किया और Contributor Days में tables भी lead करने लगा।</p>



<p class="wp-block-paragraph">मैं <strong>do_action Bhopal</strong> में Content and Social Media Manager के लिए चुना गया और बाद में Project Manager बना दिया गया।</p>



<p class="wp-block-paragraph">कागज़ पर देखें तो ये सब achievements लगती हैं।</p>



<p class="wp-block-paragraph">लेकिन मुझे ये इस तरह याद नहीं हैं।</p>



<p class="wp-block-paragraph">मुझे meetings याद हैं, जहाँ मैं सोचता था कि मेरा idea सही भी है या नहीं।</p>



<p class="wp-block-paragraph">मुझे अपने सवाल पूछना याद है।</p>



<p class="wp-block-paragraph">मुझे याद है कि लोग धैर्य से चीज़ें समझाते थे।</p>



<p class="wp-block-paragraph">मुझे याद है वह एहसास जब मुझे पहली बार लगा कि मैं वास्तव में useful हो सकता हूँ।</p>



<p class="wp-block-paragraph">और मुझे वह feeling याद है जब मेरे काम की कोई छोटी-सी चीज़ मेरे से कहीं बड़ी किसी चीज़ का हिस्सा बन गई।</p>



<p class="wp-block-paragraph">शायद वहीं से contribution मेरे लिए बदलना शुरू हुआ।</p>



<p class="wp-block-paragraph">यह सवाल कम होने लगा कि:</p>



<p class="wp-block-paragraph"><strong>“मुझे WordPress से क्या मिल सकता है?”</strong></p>



<p class="wp-block-paragraph">और उसकी जगह एक दूसरा सवाल आने लगा:</p>



<p class="wp-block-paragraph"><strong>“मैं WordPress को क्या दे सकता हूँ?”</strong></p>



<h2 class="wp-block-heading" id="h-कह-न-म-ल-ग-आन-लग"><strong>कहानी में लोग आने लगे</strong></h2>



<p class="wp-block-paragraph"><br />जितना मैं contribute करता गया, उतने ही ज़्यादा लोगों से मिलता गया।</p>



<p class="wp-block-paragraph">कुछ दोस्त बन गए।</p>



<p class="wp-block-paragraph">कुछ mentors बन गए।</p>



<p class="wp-block-paragraph">कुछ ऐसे लोग थे जिन्होंने बस community में जिस तरह अपनी जगह बनाई और दूसरों के लिए मौजूद रहे, उससे मुझे inspiration मिली।</p>



<p class="wp-block-paragraph"><strong>Michelle Frechette</strong> मेरे लिए ऐसे ही लोगों में से एक रही हैं। उनके साथ <strong>Topher DeRosia, Isotta Peira,</strong> <strong>Nidhi Jain, Ganga Kafle,</strong> और कई दूसरे लोग भी हैं।</p>



<p class="wp-block-paragraph">मैं इन लोगों से सिर्फ इसलिए प्रभावित नहीं हूँ कि उन्होंने क्या हासिल किया है।</p>



<p class="wp-block-paragraph">बल्कि इसलिए कि वे दूसरों को यह महसूस कराते हैं कि <strong>उनके लिए भी जगह है।</strong></p>



<p class="wp-block-paragraph">जब आप Fatehpur जैसी जगह से आते हैं और एक global community में अपनी जगह बनाने की कोशिश करते हैं, तो यह बहुत मायने रखता है।</p>



<p class="wp-block-paragraph">हर बार किसी का आपको opportunity देना ज़रूरी नहीं होता।</p>



<p class="wp-block-paragraph">कभी-कभी आपको सिर्फ किसी ऐसे व्यक्ति की ज़रूरत होती है जो आपको यह विश्वास दिला दे कि:</p>



<p class="wp-block-paragraph"><strong>“हाँ, तुम भी कोशिश कर सकते हो।”</strong></p>



<p class="wp-block-paragraph">मैं खुशकिस्मत हूँ कि मेरी journey में ऐसे लोग आए।</p>



<h2 class="wp-block-heading" id="h-contribution-स-building-तक"><strong>Contribution से building तक</strong></h2>



<p class="wp-block-paragraph"><br />मेरे दूसरे साल तक आते-आते मेरे मन में WordPress ecosystem के अंदर अपने कुछ products बनाने की इच्छा होने लगी।</p>



<p class="wp-block-paragraph">मैंने <strong>WordCamp Asia 2025</strong> में Manila में <strong>Emma Young</strong> के साथ marketing team में lead किया और volunteer किया।</p>



<p class="wp-block-paragraph">इसके साथ मैंने अपने plugins बनाना भी शुरू किया, जिसमें <strong>Harish, Bhargav, Makarand Mane, Hitanshu Sahu, और</strong> <strong>Sajid Ansari</strong> के contributions और support ने मदद की।</p>



<h3 class="wp-block-heading" id="h-पहल-थ-quoteframeshare">पहला था <strong>QuoteFrameShare</strong></h3>



<p class="wp-block-paragraph">यह लोगों को WordPress में customizable blockquotes बनाने और share करने की सुविधा देता है।</p>



<p class="wp-block-paragraph">यह project मेरे लिए खास था क्योंकि writing और poetry हमेशा से मेरी ज़िंदगी का हिस्सा रहे हैं।</p>



<p class="wp-block-paragraph">जिस चीज़ की शुरुआत fellow engineering students के लिए technology tutorials लिखने से हुई थी, वह अब घूमकर ऐसे product तक पहुँच गई थी जिसे writers, poets और storytellers के लिए बनाया जा रहा था।</p>



<h3 class="wp-block-heading" id="h-द-सर-थ-contributor-photo-gallery">दूसरा था <strong>Contributor Photo Gallery</strong></h3>



<p class="wp-block-paragraph">यह WordPress contributors को अपनी WordPress.org photo contributions को बिना code लिखे एक portfolio की तरह दिखाने में मदद करता है।</p>



<p class="wp-block-paragraph">यह मेरी journey के एक और हिस्से से आया था: photography और WordPress Photo Directory।</p>



<p class="wp-block-paragraph">मुझे अच्छा लगा कि दोनों projects छोटी और relatively simple problems को solve करते थे, लेकिन उन communities और लोगों के लिए, जो मेरे लिए सच में मायने रखते थे।</p>



<p class="wp-block-paragraph">मैं सिर्फ इसलिए plugin नहीं बना रहा था क्योंकि मैं बना सकता था।</p>



<p class="wp-block-paragraph">मैं इसलिए कुछ बना रहा था क्योंकि मेरे पास एक idea था और मुझे लगा कि वह किसी और के लिए useful हो सकता है।</p>



<h2 class="wp-block-heading" id="h-सब-क-छ-हम-श-ठ-क-नह-रह"><strong>सब कुछ हमेशा ठीक नहीं रहा</strong></h2>



<p class="wp-block-paragraph"><br />मेरी WordPress journey हमेशा सीधी ऊपर की ओर जाने वाली कहानी नहीं रही।</p>



<p class="wp-block-paragraph">एक समय ऐसा भी आया जब contribution को लेकर मेरा उत्साह इतना बढ़ गया कि मैं सब कुछ करने की कोशिश करने लगा।</p>



<p class="wp-block-paragraph">हर team।</p>



<p class="wp-block-paragraph">हर opportunity।</p>



<p class="wp-block-paragraph">हर event।</p>



<p class="wp-block-paragraph">हर possible contribution।</p>



<p class="wp-block-paragraph">मैं यह साबित करने में इतना व्यस्त हो गया था कि मैं contribute कर सकता हूँ कि मैंने अपनी ज़िंदगी की बाकी चीज़ों पर पर्याप्त ध्यान देना शुरू नहीं किया।</p>



<p class="wp-block-paragraph">आखिरकार, मैं burnout हो गया।</p>



<p class="wp-block-paragraph">मैंने यह भी सीखा कि community work की अपनी challenges होती हैं।</p>



<p class="wp-block-paragraph">हर experience अच्छा नहीं था। कुछ ऐसे moments भी आए जब मुझे लगा कि मेरी बात को देखा नहीं गया, मुझे समझा नहीं गया या मैंने discouraged महसूस किया।</p>



<p class="wp-block-paragraph">वे experiences आसान नहीं थे।</p>



<p class="wp-block-paragraph">लेकिन उन्होंने मुझे यह सोचने पर मजबूर किया कि आखिर मैं contribution से क्या चाहता हूँ।</p>



<p class="wp-block-paragraph">मुझे एहसास हुआ कि मैं अपना समय यह साबित करने में नहीं लगाना चाहता था कि मैं belong करता हूँ।</p>



<p class="wp-block-paragraph">मैं contribute इसलिए करना चाहता था क्योंकि मुझे इस project और इसमें शामिल लोगों की परवाह थी।</p>



<p class="wp-block-paragraph">इसने contribution को देखने का मेरा तरीका बदल दिया।</p>



<p class="wp-block-paragraph">मुझे समझ आया कि मुझे हर जगह होना ज़रूरी नहीं है। हर badge collect करना ज़रूरी नहीं है। सबसे बड़ा contribution count हासिल करना भी ज़रूरी नहीं है ताकि मैं यह साबित कर सकूँ कि मुझे परवाह है।</p>



<p class="wp-block-paragraph">मुझे बस ऐसा तरीका ढूँढना था जिससे मैं लंबे समय तक contribute कर सकूँ।</p>



<p class="wp-block-paragraph">मुझे यह भी समझ आया कि यह साबित करने के लिए कि मुझे परवाह है, मुझे अपनी health, livelihood या peace of mind को sacrifice करने की ज़रूरत नहीं है।</p>



<p class="wp-block-paragraph">अगर आपके पास हफ्ते में सिर्फ एक घंटा है, तो उतना ही contribute कीजिए।</p>



<p class="wp-block-paragraph">अगर आपके पास ज़्यादा समय है, तो बहुत अच्छी बात है।</p>



<p class="wp-block-paragraph">लेकिन contribution sustainable होना चाहिए।</p>



<h2 class="wp-block-heading" id="h-वह-support-ज-स-म-कभ-नह-भ-ल-ग"><strong>वह support जिसे मैं कभी नहीं भूलूँगा</strong></h2>



<p class="wp-block-paragraph"><br />शायद यही वजह है कि मैं अपनी journey के मुश्किल हिस्सों के बारे में भी ईमानदारी से बात कर सकता हूँ, क्योंकि इस community का positive side भी मेरे लिए उतना ही वास्तविक रहा है।</p>



<p class="wp-block-paragraph">लोगों ने मेरी ऐसे तरीकों से मदद की, जिसकी उन्हें कोई मजबूरी नहीं थी।</p>



<p class="wp-block-paragraph">मेरे पहले WordCamp तक पहुँचने में मिली मदद इसका एक उदाहरण है।</p>



<p class="wp-block-paragraph">बाद में <strong>Katie at Barn2</strong> ने company के events budget के ज़रिए मेरे कुछ WordCamp trips sponsor किए। <strong>Makarand</strong> ने मुझे Yoast Care Fund के लिए nominate किया, जिसे पाना मेरे लिए सौभाग्य की बात रही।</p>



<p class="wp-block-paragraph"><strong>WP Open Community Collective</strong> ने भी मुझे <strong>Contributor Day Lead Sponsorship</strong>, जिसे GoDaddy ने sponsor किया था, के ज़रिए support किया।</p>



<p class="wp-block-paragraph">और कुछ लोगों ने ऐसी मदद की जो financial बिल्कुल नहीं थी।</p>



<p class="wp-block-paragraph">लोगों ने अपना समय दिया।</p>



<p class="wp-block-paragraph">मेरे सवालों के जवाब दिए।</p>



<p class="wp-block-paragraph">मेरी recommendations कीं।</p>



<p class="wp-block-paragraph">जब मैं खुद को लेकर uncertain था, तब मुझे encourage किया गया।</p>



<p class="wp-block-paragraph">Contribution numbers की बात करते समय इन चीज़ों को आसानी से नज़रअंदाज़ किया जा सकता है।</p>



<p class="wp-block-paragraph">लेकिन मेरे लिए असली कहानी यही है।</p>



<p class="wp-block-paragraph">क्योंकि हर contribution के पीछे अक्सर एक इंसान होता है।</p>



<p class="wp-block-paragraph">और मेरी contributions के पीछे बहुत सारे ऐसे लोग हैं जिन्होंने मुझे वहाँ तक पहुँचने में मदद की।</p>



<h2 class="wp-block-heading" id="h-wordpress-न-म-झ-क-य-द-य"><strong>WordPress ने मुझे क्या दिया</strong></h2>



<p class="wp-block-paragraph"><br />जब मैं उस लड़के को पीछे मुड़कर देखता हूँ जिसने अपने fellow engineering students के लिए technology tutorials लिखना शुरू किया था, तो मुझे नहीं लगता कि उसने कभी सोचा होगा कि उसकी journey यहाँ तक आएगी।</p>



<p class="wp-block-paragraph">Technology में आने का मेरा कोई conventional रास्ता नहीं था।</p>



<p class="wp-block-paragraph">मैंने computer science की पढ़ाई नहीं की।</p>



<p class="wp-block-paragraph">मैंने WordPress की चीज़ें बनाकर, उन्हें तोड़कर और फिर उन्हें समझते हुए सीखा।</p>



<p class="wp-block-paragraph">और किसी तरह, शुरुआत करने के लिए इतना ही काफी था।</p>



<p class="wp-block-paragraph">WordPress ने मुझे technology, content, SEO, marketing, product building और community जैसी skills विकसित करने में मदद की।</p>



<p class="wp-block-paragraph">इसने मुझे दुनिया भर के लोगों के साथ काम करने के मौके दिए।</p>



<p class="wp-block-paragraph">मुझे उन WordCamps तक पहुँचाया, जिन्हें मैं कभी afford भी नहीं कर सकता था।</p>



<p class="wp-block-paragraph">इसने मुझे open-source products बनाने का मौका दिया।</p>



<p class="wp-block-paragraph">लेकिन इन सबमें से कोई भी चीज़ वह नहीं है जिसे मैं सबसे ज़्यादा महत्व देता हूँ।</p>



<p class="wp-block-paragraph"><strong>WordPress ने मुझे सबसे बड़ी चीज़ जो दी, वह लोग थे।</strong></p>



<p class="wp-block-paragraph">शायद इसीलिए मेरे लिए “success” से ज़्यादा सही शब्द <strong>“belonging”</strong> है।</p>



<p class="wp-block-paragraph">मैं WordPress पर websites बनाने आया था।</p>



<p class="wp-block-paragraph"><strong>लेकिन कहीं न कहीं, WordPress ने मेरे आसपास एक community बना दी।</strong></p>



<h2 class="wp-block-heading" id="h-म-अभ-भ-इस-समझन-क-क-श-श-कर-रह-ह"><strong>मैं अभी भी इसे समझने की कोशिश कर रहा हूँ</strong></h2>



<p class="wp-block-paragraph"><br />मुझे अभी भी ठीक से नहीं पता कि WordPress मुझे आगे कहाँ ले जाएगा।</p>



<p class="wp-block-paragraph">मैं products बनाते रहना चाहता हूँ।</p>



<p class="wp-block-paragraph">मैं marketing और product के क्षेत्र में और आगे बढ़ना चाहता हूँ।</p>



<p class="wp-block-paragraph">मैं partnerships और community के बारे में और explore करना चाहता हूँ।</p>



<p class="wp-block-paragraph">और एक दिन, मैं WordPress release को co-lead करना चाहता हूँ।</p>



<p class="wp-block-paragraph">लेकिन मैं इन चीज़ों के पीछे सिर्फ किसी title या badge के लिए नहीं भागना चाहता।</p>



<p class="wp-block-paragraph">मैं ऐसी चीज़ें बनाना चाहता हूँ जो सच में useful हों।</p>



<p class="wp-block-paragraph">मैं अपने काम में बेहतर बनना चाहता हूँ।</p>



<p class="wp-block-paragraph">मैं उन लोगों की मदद करना चाहता हूँ जो आज वहीं खड़े हैं जहाँ मैं कुछ साल पहले था।</p>



<p class="wp-block-paragraph">और मैं ऐसा इंसान बनना चाहता हूँ कि जब कोई अपने WordPress journey के शुरुआती दिनों को याद करे, तो शायद वह कह सके:</p>



<p class="wp-block-paragraph"><strong>“Satya ने मेरी शुरुआत में मेरी मदद की थी।”</strong></p>



<p class="wp-block-paragraph">मेरे लिए वह किसी भी badge से ज़्यादा मायने रखेगा।</p>



<p class="wp-block-paragraph">क्योंकि मेरे साथ भी यही हुआ था।</p>



<p class="wp-block-paragraph">लोगों ने मेरी शुरुआत में मेरी मदद की।</p>



<p class="wp-block-paragraph">लोगों ने मेरे लिए जगह बनाई।</p>



<p class="wp-block-paragraph">लोगों ने मुझे encourage किया।</p>



<p class="wp-block-paragraph">लोगों ने मुझ पर भरोसा किया, उस समय भी जब मुझे खुद पूरी तरह यकीन नहीं था कि मैं contribute कर सकता हूँ।</p>



<p class="wp-block-paragraph">इसलिए अगर आप अपनी WordPress journey अभी शुरू कर रहे हैं, तो मेरी सलाह बहुत simple है:</p>



<p class="wp-block-paragraph"><strong>छोटे से शुरू कीजिए। सवाल पूछिए। जो पसंद है, उसे खोजिए। लगातार contribute कीजिए, लेकिन अपनी capacity के भीतर।</strong></p>



<p class="wp-block-paragraph">आपको शुरुआत करने से पहले सब कुछ पता होना ज़रूरी नहीं है।</p>



<p class="wp-block-paragraph">मुझे भी नहीं पता था।</p>



<p class="wp-block-paragraph">मैंने लिखना इसलिए शुरू किया क्योंकि मैं अपने classmates के लिए मुश्किल चीज़ों को आसान बनाना चाहता था।</p>



<p class="wp-block-paragraph">मैंने blogging इसलिए शुरू की क्योंकि technology को लेकर मेरे अंदर curiosity थी।</p>



<p class="wp-block-paragraph">मैंने WordPress इसलिए शुरू किया क्योंकि मेरे भाई ने मुझे दिखाया कि इसके साथ क्या किया जा सकता है।</p>



<p class="wp-block-paragraph">मैं सीखता रहा क्योंकि हमेशा कुछ नया सीखने के लिए था।</p>



<p class="wp-block-paragraph">और आखिरकार, मैंने contribute करना शुरू किया क्योंकि मैं कुछ वापस देना चाहता था।</p>



<p class="wp-block-paragraph">लेकिन कहीं न कहीं, इस journey के दौरान कुछ और भी हुआ।</p>



<p class="wp-block-paragraph">मुझे लोग मिले।</p>



<p class="wp-block-paragraph">मुझे opportunities मिलीं।</p>



<p class="wp-block-paragraph">मुझे एक community मिली।</p>



<p class="wp-block-paragraph">और मुझे एक ऐसी जगह मिली जहाँ मैं सीखता रह सकता था, contribute करता रह सकता था और हर दिन थोड़ा बेहतर बनता रह सकता था।</p>



<p class="wp-block-paragraph"><strong>मैं WordPress पर वेबसाइटें बनाने आया था।</strong></p>



<p class="wp-block-paragraph"><strong>लेकिन कहीं न कहीं, WordPress ने मेरे आसपास एक community बना दी।</strong><strong><br /></strong><strong><br /></strong>और शायद यही इस पूरी journey का असली मतलब है।</p>



<p class="wp-block-paragraph" id="h-blogging-स-belonging-तक"><strong>Blogging से Belonging तक।</strong></p>
<p>The post <a href="https://heropress.com/essays/from-blogging-to-belonging-my-wordpress-journey/">From Blogging to Belonging: My WordPress Journey &#8211; Blogging से Belonging तक: मेरी WordPress Journey</a> appeared first on <a href="https://heropress.com">HeroPress</a>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 29 Sep 2026 11:43:21 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:18:"Satyam Vishwakarma";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:28;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:60:"Open Channels FM: What Can You Learn From 4.4 Million Words?";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2562978";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:66:"https://openchannels.fm/what-can-you-learn-from-4-4-million-words/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:232:"In this episode, Bob Dunn discusses utilizing 4.4 million words from Open Channels FM's podcasts and blog posts. He highlights tools like Jetpack AI Search and Site Chat, enhancing users' access to valuable insights and discussions.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 29 Sep 2026 09:42:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"Bob Dunn";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:29;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:62:"OpenStation Blog: WordPress Has Been Missing This for 15 Years";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"https://openstation.blog/?p=1342";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:81:"https://openstation.blog/2026/09/28/wordpress-has-been-missing-this-for-15-years/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:16418:"<blockquote class="wp-block-quote is-layout-flow wp-block-quote-is-layout-flow">
<p class="wp-block-paragraph">tl;dr:</p>



<p class="wp-block-paragraph">15 years stuck in the same wp-admin, why don&#8217;t you try in playground the <a href="https://playground.wordpress.net/?mode=seamless&amp;storage=temp#%7B%22landingPage%22%3A%22%2Fdesktop-mode%2F%22%2C%22preferredVersions%22%3A%7B%22php%22%3A%228.3%22%2C%22wp%22%3A%22latest%22%7D%2C%22features%22%3A%7B%22networking%22%3Atrue%7D%2C%22siteOptions%22%3A%7B%22blogname%22%3A%22OpenStation%22%7D%2C%22steps%22%3A%5B%7B%22step%22%3A%22login%22%2C%22username%22%3A%22admin%22%2C%22password%22%3A%22password%22%7D%2C%7B%22step%22%3A%22mkdir%22%2C%22path%22%3A%22%2Fwordpress%2Fwp-content%2Fmu-plugins%22%7D%2C%7B%22step%22%3A%22writeFile%22%2C%22path%22%3A%22%2Fwordpress%2Fwp-content%2Fmu-plugins%2Fopenstation-demo-no-core-update.php%22%2C%22data%22%3A%22%3C%3Fphp%5Cn%2F%2A%2A%5Cn%20%2A%20Demo%20only.%20Playground%20pins%20WordPress%20to%20a%20major.minor%20build%2C%20so%20its%207.0%5Cn%20%2A%20trails%20the%20newest%20patch%20release%20and%20wp-admin%20offers%20an%20update%20a%20throwaway%5Cn%20%2A%20sandbox%20cannot%20usefully%20apply.%20Report%20%5C%22no%20core%20updates%5C%22%20so%20the%20demo%20shows%5Cn%20%2A%20OpenStation%20instead%20of%20an%20update%20nag.%5Cn%20%2A%5Cn%20%2A%20This%20also%20clears%20OpenStation%27s%20own%20release%20notification%2C%20which%20reads%20the%5Cn%20%2A%20same%20data%20via%20get_preferred_from_update_core%28%29.%5Cn%20%2A%2F%5Cnadd_filter%28%5Cn%5Ct%27pre_site_transient_update_core%27%2C%5Cn%5Ctstatic%20function%20%28%29%20%7B%5Cn%5Ct%5Ctreturn%20%28object%29%20array%28%5Cn%5Ct%5Ct%5Ct%27updates%27%20%20%20%20%20%20%20%20%20%3D%3E%20array%28%29%2C%5Cn%5Ct%5Ct%5Ct%27version_checked%27%20%3D%3E%20%24GLOBALS%5B%27wp_version%27%5D%2C%5Cn%5Ct%5Ct%5Ct%27last_checked%27%20%20%20%20%3D%3E%20time%28%29%2C%5Cn%5Ct%5Ct%29%3B%5Cn%5Ct%7D%5Cn%29%3B%5Cn%22%7D%2C%7B%22step%22%3A%22installPlugin%22%2C%22pluginData%22%3A%7B%22resource%22%3A%22wordpress.org%2Fplugins%22%2C%22slug%22%3A%22desktop-mode%22%7D%2C%22options%22%3A%7B%22activate%22%3Atrue%7D%7D%2C%7B%22step%22%3A%22runPHP%22%2C%22code%22%3A%22%3C%3Fphp%5Cnrequire_once%20%27%2Fwordpress%2Fwp-load.php%27%3B%5Cn%2F%2F%20Open%20straight%20onto%20the%20desktop%20rather%20than%20the%20per-user%20opt-in%20screen%2C%5Cn%2F%2F%20and%20drop%20Core%27s%20welcome%20panel.%20Was%20two%20wp-cli%20steps%2C%20which%20dragged%5Cn%2F%2F%20wp-cli.phar%20into%20the%20boot%20for%20two%20one-line%20writes.%5Cnupdate_user_meta%28%201%2C%20%27desktop_mode_mode%27%2C%201%20%29%3B%5Cnupdate_user_meta%28%201%2C%20%27show_welcome_panel%27%2C%200%20%29%3B%5Cn%22%7D%5D%7D">new wp-admin experience</a>?</p>
</blockquote>



<p class="wp-block-paragraph">WordPress has spent the <strong>last fifteen years</strong> becoming capable of doing almost everything, yet somehow we have continued interacting with wp-admin in fundamentally the same way: click somewhere, load another screen, go back, open another tab because you do not want to lose the previous one, and after a while end up with ten different WordPress tabs scattered across your browser.</p>



<p class="wp-block-paragraph">I find it quite funny that we all accepted this as completely normal.</p>



<p class="wp-block-paragraph">Today WordPress is used to run <strong>stores, publications, membership sites, communities, LMS platforms, agencies and entire businesses</strong>. We have plugins that are effectively full applications, incredibly complex editing experiences, analytics, forms, CRM systems, media tools, commerce, automation and thousands of other things living inside the same installation. Yet the interface connecting all of them still assumes that, most of the time, you want to look at one thing at once.</p>



<p class="wp-block-paragraph">And when you don&#8217;t, <strong>the browser</strong> has to solve the problem for us.</p>



<p class="wp-block-paragraph"><strong>Browser tabs have essentially become the window manager of WordPress.</strong></p>



<figure class="wp-block-image aligncenter size-full"><img alt="" class="wp-image-1344" height="54" src="https://i0.wp.com/openstation.blog/wp-content/uploads/2026/09/image-13.png?resize=535%2C54&#038;ssl=1" width="535" /></figure>



<p class="wp-block-paragraph">That is one of the ideas that eventually led us to <strong>OpenStation</strong>.</p>



<h2 class="wp-block-heading">Why don&#8217;t we have windows?</h2>



<p class="wp-block-paragraph">It sounds ridiculously obvious when you phrase it like that, but that is exactly why I find the question interesting.</p>



<p class="wp-block-paragraph">On a normal computer I can have my editor open next to a browser, keep a terminal in the background, drag files around, minimize something I want to return to later, or simply arrange my workspace around whatever I am doing at that moment. Nobody thinks about this as a feature anymore because it is just how computers work.</p>



<p class="wp-block-paragraph"><strong>Then we open WordPress and suddenly that whole model disappears.</strong></p>



<figure class="wp-block-image size-large"><img alt="" class="wp-image-1346" height="631" src="https://i0.wp.com/openstation.blog/wp-content/uploads/2026/09/image-14.png?resize=1024%2C631&#038;ssl=1" width="1024" /></figure>



<p class="wp-block-paragraph">If I am editing a post and need something from the Media Library, I navigate away or open another tab. If I am checking an order while editing a product, another tab. If I want to compare two posts, another tab. If I am configuring something and need to check how another part of the site is set up, another tab.</p>



<p class="wp-block-paragraph">There is nothing technically wrong with that, of course, and it has worked for years, but after building and using OpenStation every day I started noticing how much context we constantly throw away simply because wp-admin was designed around pages rather than workspaces.</p>



<p class="wp-block-paragraph">That distinction matters much more today than it probably did fifteen years ago.</p>



<h2 class="wp-block-heading">WordPress quietly became something much bigger</h2>



<p class="wp-block-paragraph">I keep describing WordPress as the operating system of the web, and obviously I do not mean that literally. What I mean is that WordPress has gradually accumulated many of the characteristics you would expect from a platform where applications live.</p>



<p class="wp-block-paragraph">Plugins install capabilities into it. Users have identities and permissions. Applications share data. We have APIs, scheduled processes, notifications, media, editors, databases and an enormous ecosystem of software that knows how to work with the same underlying environment.</p>



<p class="wp-block-paragraph">The strange part is that the interface never fully made the same transition.</p>



<p class="wp-block-paragraph">We kept adding more applications to WordPress, but we continued presenting them largely as destinations in a menu.</p>



<p class="wp-block-paragraph">OpenStation started from a very simple thought: what happens if, instead of redesigning every individual wp-admin page again, we change the environment in which those pages live?</p>



<figure class="wp-block-image size-large"><img alt="" class="wp-image-1308" height="568" src="https://i0.wp.com/openstation.blog/wp-content/uploads/2026/09/HS_NADgXsAABwZg.jpeg?resize=1024%2C568&#038;ssl=1" width="1024" /></figure>



<p class="wp-block-paragraph">That immediately opens a much larger set of possibilities.</p>



<p class="wp-block-paragraph">A post editor does not need to replace your media library on screen. A WooCommerce order does not need to replace the product you were editing. A plugin screen does not necessarily need to occupy the entire browser just because you clicked its menu item.</p>



<p class="wp-block-paragraph"><strong>They can simply be windows.</strong></p>



<p class="wp-block-paragraph">You can move them, resize them, minimize them, keep several of them open, organise them across different desktops and return to exactly what you were doing without recreating the context again.</p>



<p class="wp-block-paragraph">The funny thing is that none of this feels particularly futuristic. Quite the opposite. We have been using computers this way for decades.</p>



<p class="wp-block-paragraph">We just somehow never brought that interaction model into wp-admin.</p>



<h2 class="wp-block-heading">The interesting part is not actually the windows</h2>



<p class="wp-block-paragraph">The windows are what people notice first because they are visual, but I think the more important idea is what happens once WordPress stops assuming that navigation must destroy context.</p>



<p class="wp-block-paragraph">Suddenly the admin becomes a workspace.</p>



<p class="wp-block-paragraph">You can have the Media Library next to the editor instead of travelling between them. You can keep an order visible while checking something else. You can open notes or widgets without abandoning your current task. <strong>Applications can coexist on the same desktop</strong> and eventually interact with each other in ways that become much harder when everything is isolated in separate browser tabs.</p>



<p class="wp-block-paragraph">This is also where things like drag and drop become much more interesting.</p>



<p class="wp-block-paragraph">If two applications are part of the same environment, moving an image, a product, a post or another WordPress entity between them can become an actual interaction instead of a sequence of copy, navigate, search, paste and navigate back.</p>



<p class="wp-block-paragraph">And once you start thinking about WordPress this way, a lot of things that initially looked like unrelated OpenStation features start making sense together: windows, the dock, multiple desktops, widgets, the command palette and applications are all different pieces of the same idea.</p>



<p class="wp-block-paragraph">The goal is not to decorate wp-admin until it looks like a desktop operating system. The goal is to make working in WordPress feel less like navigating a website and more like working inside an environment.</p>



<h2 class="wp-block-heading">We don&#8217;t need to replace wp-admin to do this</h2>



<p class="wp-block-paragraph">This is probably the part I like the most about the approach.</p>



<p class="wp-block-paragraph">WordPress already has an enormous ecosystem and rebuilding everything would be both unrealistic and, in my opinion, the wrong problem to solve. There are thousands of admin interfaces that already work, plugins developers have spent years building, and workflows users already understand.</p>



<p class="wp-block-paragraph">OpenStation can sit on top of that rather than asking the ecosystem to start again.</p>



<p class="wp-block-paragraph">The existing WordPress admin can continue being WordPress. Existing plugins can continue exposing their interfaces. What changes is how those interfaces are presented and how you move between them.</p>



<p class="wp-block-paragraph">In some ways, I think that is much more interesting than simply designing another admin UI.</p>



<p class="wp-block-paragraph">We are not trying to decide what every WordPress application should look like. We are trying to give those applications a better place to live.</p>



<p class="wp-block-paragraph">And once you have that place, building actual OpenStation-native applications becomes possible as well. We have already been experimenting with things like a photo editor, project management tools and forms, but what excites me is not any individual application. It is the idea that WordPress can host an entire collection of tools that feel like they belong to the same workspace instead of a collection of isolated screens connected by a sidebar.</p>



<h2 class="wp-block-heading">So why did it take fifteen years?</h2>



<p class="wp-block-paragraph"><strong>Probably because there was never a single moment where the old model stopped working.</strong></p>



<p class="wp-block-paragraph">WordPress evolved gradually. A new menu here, another plugin there, a more sophisticated editor, WooCommerce, custom post types, page builders, analytics, SEO tools and so on. Each addition fitted reasonably well into what already existed, so there was never an obvious reason to stop and question the basic interaction model.</p>



<p class="wp-block-paragraph">But those small changes accumulated.</p>



<p class="wp-block-paragraph">The WordPress of today asks considerably more from wp-admin than the WordPress of fifteen years ago did, and I think that eventually creates an opportunity to revisit assumptions that once seemed completely reasonable.</p>



<p class="wp-block-paragraph">The assumption we are questioning with OpenStation is a very simple one:</p>



<p class="wp-block-paragraph">Why should opening something in WordPress mean leaving everything else behind?</p>



<p class="wp-block-paragraph">After spending months working this way, I now notice it every time I go back to the traditional flow. I open something, realise I need another part of WordPress, create another browser tab and immediately think: why am I doing this outside WordPress when WordPress itself could manage the workspace?</p>



<p class="wp-block-paragraph">That is probably the best way I can explain what we are building.</p>



<p class="wp-block-paragraph">WordPress has had applications for a very long time.</p>



<p class="wp-block-paragraph">Perhaps what it has been missing all these years is somewhere for those applications to actually live together.</p>



<p class="wp-block-paragraph">By the way, don&#8217;t forget you can always try OpenStation without even installing it in your site, using <a href="https://playground.wordpress.net/?mode=seamless&amp;storage=temp#%7B%22landingPage%22%3A%22%2Fdesktop-mode%2F%22%2C%22preferredVersions%22%3A%7B%22php%22%3A%228.3%22%2C%22wp%22%3A%22latest%22%7D%2C%22features%22%3A%7B%22networking%22%3Atrue%7D%2C%22siteOptions%22%3A%7B%22blogname%22%3A%22OpenStation%22%7D%2C%22steps%22%3A%5B%7B%22step%22%3A%22login%22%2C%22username%22%3A%22admin%22%2C%22password%22%3A%22password%22%7D%2C%7B%22step%22%3A%22mkdir%22%2C%22path%22%3A%22%2Fwordpress%2Fwp-content%2Fmu-plugins%22%7D%2C%7B%22step%22%3A%22writeFile%22%2C%22path%22%3A%22%2Fwordpress%2Fwp-content%2Fmu-plugins%2Fopenstation-demo-no-core-update.php%22%2C%22data%22%3A%22%3C%3Fphp%5Cn%2F%2A%2A%5Cn%20%2A%20Demo%20only.%20Playground%20pins%20WordPress%20to%20a%20major.minor%20build%2C%20so%20its%207.0%5Cn%20%2A%20trails%20the%20newest%20patch%20release%20and%20wp-admin%20offers%20an%20update%20a%20throwaway%5Cn%20%2A%20sandbox%20cannot%20usefully%20apply.%20Report%20%5C%22no%20core%20updates%5C%22%20so%20the%20demo%20shows%5Cn%20%2A%20OpenStation%20instead%20of%20an%20update%20nag.%5Cn%20%2A%5Cn%20%2A%20This%20also%20clears%20OpenStation%27s%20own%20release%20notification%2C%20which%20reads%20the%5Cn%20%2A%20same%20data%20via%20get_preferred_from_update_core%28%29.%5Cn%20%2A%2F%5Cnadd_filter%28%5Cn%5Ct%27pre_site_transient_update_core%27%2C%5Cn%5Ctstatic%20function%20%28%29%20%7B%5Cn%5Ct%5Ctreturn%20%28object%29%20array%28%5Cn%5Ct%5Ct%5Ct%27updates%27%20%20%20%20%20%20%20%20%20%3D%3E%20array%28%29%2C%5Cn%5Ct%5Ct%5Ct%27version_checked%27%20%3D%3E%20%24GLOBALS%5B%27wp_version%27%5D%2C%5Cn%5Ct%5Ct%5Ct%27last_checked%27%20%20%20%20%3D%3E%20time%28%29%2C%5Cn%5Ct%5Ct%29%3B%5Cn%5Ct%7D%5Cn%29%3B%5Cn%22%7D%2C%7B%22step%22%3A%22installPlugin%22%2C%22pluginData%22%3A%7B%22resource%22%3A%22wordpress.org%2Fplugins%22%2C%22slug%22%3A%22desktop-mode%22%7D%2C%22options%22%3A%7B%22activate%22%3Atrue%7D%7D%2C%7B%22step%22%3A%22runPHP%22%2C%22code%22%3A%22%3C%3Fphp%5Cnrequire_once%20%27%2Fwordpress%2Fwp-load.php%27%3B%5Cn%2F%2F%20Open%20straight%20onto%20the%20desktop%20rather%20than%20the%20per-user%20opt-in%20screen%2C%5Cn%2F%2F%20and%20drop%20Core%27s%20welcome%20panel.%20Was%20two%20wp-cli%20steps%2C%20which%20dragged%5Cn%2F%2F%20wp-cli.phar%20into%20the%20boot%20for%20two%20one-line%20writes.%5Cnupdate_user_meta%28%201%2C%20%27desktop_mode_mode%27%2C%201%20%29%3B%5Cnupdate_user_meta%28%201%2C%20%27show_welcome_panel%27%2C%200%20%29%3B%5Cn%22%7D%5D%7D">WordPress playgrounds</a></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 28 Sep 2026 12:57:03 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Daniel López";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:30;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:39:"Open Channels FM: Open Source Champions";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2563023";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:46:"https://openchannels.fm/open-source-champions/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:209:"The Open Source Champions initiative invites individuals and brands to support the network through a unique advocacy opportunity, offering exposure, promotional features, and participation in special episodes.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 28 Sep 2026 12:17:19 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:3:"Bob";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:31;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:113:"Gutenberg Times: Gutenberg 24.0, the road to 7.2, a new default theme named Ipsum, and more—Weekend Edition 377";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"https://gutenbergtimes.com/?p=47181";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:119:"https://gutenbergtimes.com/gutenberg-24-0-the-road-to-7-2-a-new-default-theme-named-ipsum-and-more-weekend-edition-377/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:34343:"<p class="wp-block-paragraph">Howdy,</p>



<p class="wp-block-paragraph">Before anything else: if you maintain WordPress sites, go update them. <a href="https://wordpress.org/news/2026/09/wordpress-7-1-2-release/"><strong>WordPress 7.1.2</strong></a> shipped on September 22 to patch a single critical vulnerability in page template resolution, one that lets an unauthenticated attacker load a chosen PHP file from outside your active theme&#8217;s directories.</p>



<p class="wp-block-paragraph">Now let&#8217;s move on to better things. <strong>Anne McCarthy</strong> is <a href="https://nomad.blog/2026/09/24/auctioning-off-my-wordpress-release-albums/"><strong>auctioning off her framed WordPress release albums</strong></a>, the ones given to release squad members. All the proceeds go to Stimpunks, a nonprofit started by <strong>Ryan Boren</strong>, who joined the project in 2003 and wrote the plugin system that nearly every site runs on. She calls the albums &#8220;a form of a gold medal to me,&#8221; and she built the auction site herself in a week. The starting bid is $500.</p>



<p class="wp-block-paragraph">We also learned this fortnight that the next default theme <a href="https://make.wordpress.org/core/2026/09/16/introducing-ipsum-the-new-default-theme/"><strong>will be called Ipsum</strong></a>, which means 16 years of naming themes after the calendar is over. Admittedly, I&#8217;ll miss the old <em>Twenty*</em> names a little. But it&#8217;s time for something new for a new era.</p>



<p class="wp-block-paragraph">Two more quick things: WordPress has <a href="https://wordpress.org/news/2026/09/owa-president/"><strong>taken its turn leading the Open Website Alliance</strong></a>, alongside Drupal, Joomla!, and TYPO3, with <strong>Mary Hubbard</strong> holding the rotating presidency for the WordPress Foundation. And starting with 7.2 in December, release parties <a href="https://make.wordpress.org/core/2026/09/23/iterating-from-live-events-to-livestreamed-releases/"><strong>move from in-person events to livestreamed webinars</strong></a>, so the whole squad can actually be there.</p>



<p class="wp-block-paragraph">Enjoy your weekend!</p>



<p class="wp-block-paragraph">Your friendly neighborhood dev advocate, <img alt="🍂" class="wp-smiley" src="https://s.w.org/images/core/emoji/17.0.2/72x72/1f342.png" style="height: 1em;" /><br /><em>Justin Tadlock</em></p>


<div class="wp-block-newsletterglue-showhide ng-block" width="100%">
<div class="wp-block-group has-accent-5-background-color has-background has-global-padding is-layout-constrained wp-container-core-group-is-layout-b14348ac wp-block-group-is-layout-constrained">
<p class="wp-block-paragraph"><strong>Table of Contents</strong></p>


<nav class="wp-block-table-of-contents"><ul><li><a class="wp-block-table-of-contents__entry" href="https://gutenbergtimes.com/feed/#0-word-press-release-information">Developing Gutenberg and WordPress</a></li><li><a class="wp-block-table-of-contents__entry" href="https://gutenbergtimes.com/feed/#0-p">Plugins, Themes, and Tools for #nocode site builders and owners</a></li><li><a class="wp-block-table-of-contents__entry" href="https://gutenbergtimes.com/feed/#2-word-press-6-0-1-and-6-1-scheduled">Theme Development for Full Site Editing and Blocks</a></li><li><a class="wp-block-table-of-contents__entry" href="https://gutenbergtimes.com/feed/#3-building-themes-for-fse-and-word-press">Building Blocks and Tools for the Block editor</a></li><li><a class="wp-block-table-of-contents__entry" href="https://gutenbergtimes.com/feed/#ai-in-wordpress">AI in WordPress</a></li></ul></nav></div>
</div>


<hr class="wp-block-separator has-alpha-channel-opacity" />



<h2 class="wp-block-heading" id="0-word-press-release-information">Developing Gutenberg and WordPress</h2>



<p class="wp-block-paragraph">Two security releases in six days. <a href="https://wordpress.org/news/2026/09/wordpress-7-1-2-release/"><strong>WordPress 7.1.2</strong></a> is the urgent one, and it&#8217;s security-only: an unauthenticated attacker can, under the right conditions, make page template resolution include a readable local PHP file from outside the active theme directories. <strong>John Blackbourn</strong> led the release, <strong>Robert Ressl</strong> disclosed it, and the fix was backported to every eligible branch going back to 4.7.</p>



<p class="wp-block-paragraph">Five days earlier, <a href="https://wordpress.org/news/2026/09/wordpress-7-1-1-maintenance-and-security-release/"><strong>WordPress 7.1.1</strong></a> arrived as the regular maintenance release with 11 security fixes, 17 bug fixes on Core, and 19 for the Block Editor. <strong>Aaron Jorbin</strong> led it, and Anthropic is credited twice in the security list.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<p class="wp-block-paragraph"><strong>Aki Hamano</strong> announced <a href="https://make.wordpress.org/core/2026/09/16/whats-new-in-gutenberg-24-0-16-september/"><strong>what&#8217;s new in Gutenberg 24.0</strong></a>. The big feature: post title changes now show up in revisions with a proper diff, so you can stop guessing when a rename happened. The Gallery block gains a Grid variation with column count and &#8220;crop images to fit&#8221; configurable per breakpoint, and Site Title picks up fit-text, scaling to the width available instead of a fixed point size. And nearly 100 icons were redrawn on a stroke-based grid.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<p class="wp-block-paragraph">Stalled out somewhere between &#8220;clone the repo&#8221; and &#8220;why won&#8217;t this build&#8221;? <a href="https://make.wordpress.org/core/2026/09/25/wordpress-contributor-toolkit-1-2-one-app-for-your-first-core-or-gutenberg-contribution/"><strong>Contributor Toolkit 1.2</strong></a> from <strong>JuanMa Garrido</strong> now covers Gutenberg as well as Core, and it runs a stock WordPress in Playground with your checkout mounted as the plugin, already activated. No local server, no Docker.</p>



<h3 class="wp-block-heading" id="the-road-to-7-2"><strong>The road to 7.2</strong></h3>



<p class="wp-block-paragraph"><strong>Anne McCarthy</strong> published the <a href="https://make.wordpress.org/core/2026/09/18/roadmap-to-7-2/"><strong>roadmap to 7.2</strong></a>, and it looks to be a security-heavy cycle by WordPress standards. Sudo mode gates sensitive admin actions behind re-authentication, a new Secrets API gives credentials &#8220;a first-class way to store credentials safely,&#8221; and Application Passwords get hardened. Notes should gain a suggestion mode and emoji reactions. Designers get form element customization in Global Styles and custom block states. The final release lands in early December.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<p class="wp-block-paragraph">Real-time collaboration came out of WordPress 7.0, and <strong>Chris Zarate</strong> has now explained why in a post on <a href="https://make.wordpress.org/core/2026/09/18/moving-to-a-server-aware-approach-for-collaboration/"><strong>moving to a server-aware approach for collaboration</strong></a>, written with <strong>Alec Geatches</strong>, <strong>Dennis Snell</strong>, <strong>ingeniumed</strong>, and <strong>Paul Kevan</strong>. The old design had browsers hold the post in a CRDT document and sync peer-to-peer, which broke three ways: the server couldn&#8217;t tell who made which edit, opening the door to content laundering; REST API and WP-CLI updates couldn&#8217;t participate, so saves became all-or-nothing overwrites; and a dropped connection could take your work with it. Three candidate sync engines are on the table, with a gutenberg-sync-engines repo to test against. If you build editorial tooling, have an opinion about this now.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<p class="wp-block-paragraph">The next default theme has a name, and for the first time in well over a decade, it isn&#8217;t a year. <strong>Henrique Iamarino</strong> introduced <a href="https://make.wordpress.org/core/2026/09/16/introducing-ipsum-the-new-default-theme/"><strong>Ipsum</strong></a>, built with <strong>Carolina Nymark</strong>, <strong>Maggie Cabrera</strong>, and <strong>Juanfra Aldasoro</strong>. The reasoning behind the naming change: &#8220;default themes will have their own names and change when the design calls for it, not when the calendar does.&#8221; The theme is intentionally spare. It’s blog-first, has minimal typesets, and structural elements that stay invisible until you need them. The request is simple: &#8220;try it and tell us what breaks and what&#8217;s missing.&#8221;</p>



<figure class="wp-block-image size-large has-custom-border"><img alt="Screenshot of the Ipsum WordPress theme single post demo, including a Gallery block demo." class="has-border-color has-accent-5-border-color wp-image-47182" height="1024" src="https://i0.wp.com/gutenbergtimes.com/wp-content/uploads/2026/09/ipsum-single.jpg?resize=1006%2C1024&#038;ssl=1" style="border-width: 1px;" width="1006" /></figure>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<p class="wp-block-paragraph"><strong>Nik Tsekouras</strong> opened a <a href="https://make.wordpress.org/core/2026/09/17/call-for-testing-dataform-editor-inspector/"><strong>call for testing the DataForm editor inspector</strong></a>, which rebuilds the Post and Page tab of the Settings sidebar so it stops drifting from Quick Edit in the Site Editor. Install Gutenberg 24.0 or later and enable <strong>Editor Inspector: Use DataForm</strong> under <strong>Settings → Gutenberg</strong>. Test it as an editor, author, and contributor, not just as an admin.</p>



<h3 class="wp-block-heading" id="behind-the-release"><strong>Behind the release</strong></h3>



<p class="wp-block-paragraph">A minor release can touch more than twenty branches, and much of that work was done by hand. <strong>Lance Willett</strong> opened a <a href="https://make.wordpress.org/core/2026/09/23/new-public-repo-core-release-tools/"><strong>public repo of Core release tools</strong></a>, which includes tagging, release docs, SVN merge verification, and contributor lists.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<p class="wp-block-paragraph"><strong>Huzaifa Al Mesbah</strong> counted <a href="https://make.wordpress.org/test/2026/09/18/thank-you-to-the-wordpress-7-1-test-contributors/"><strong>84 people who tested WordPress 7.1</strong></a> across 337 Trac tickets. Fifty were first-timers, which is 60% of everyone who showed up. The most important line: &#8220;you don&#8217;t need to be a developer.&#8221; 7.2 testing is open now.</p>



<h2 class="wp-block-heading" id="0-p">Plugins, Themes, and Tools for #nocode site builders and owners</h2>



<p class="wp-block-paragraph">WooCommerce 11.2 lands the week of October 6, so read <strong>Shani Banerjee&#8217;s</strong> <a href="https://developer.woocommerce.com/2026/09/21/woocommerce-11-2-0-pre-release-notes/"><strong>pre-release notes</strong></a> before it arrives rather than after. Order withdrawal emails become configurable, the CSV importer can match products by Global Unique ID when neither ID nor SKU is available, and checkout fields gain date support with min/max validation. Two of the seventeen developer advisories will bite if you ignore them: date filters in <code>wc_get_orders()</code> and <code>wc_get_products()</code> now read a bare date as a day in your store&#8217;s timezone rather than UTC, and the Cart and Checkout order summary becomes a fixed 360px column with the two-column breakpoint moving from 700px to 920px.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<p class="wp-block-paragraph">Two dot releases arrived in between, both flagged as security updates. <a href="https://developer.woocommerce.com/2026/09/22/woocommerce-11-1-2/"><strong>WooCommerce 11.1.2</strong></a> fixes the infinite recursion that was breaking product variation galleries, and <a href="https://developer.woocommerce.com/2026/09/18/woocommerce-11-1-1/"><strong>11.1.1</strong></a> hardened API permissions and session handling.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<p class="wp-block-paragraph">The latest <a href="https://wordpress.com/blog/2026/09/15/changelog-custom-ai-themes/"><strong>WordPress.com changelog</strong></a> moves the AI website builder from picking a theme to generating one: on Premium and Business plans, it &#8220;now generates a fully custom theme built around your goals and brand.&#8221; A new <strong>Annotate</strong> feature lets you queue several targeted edits and send them at once.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<p class="wp-block-paragraph">GatherPress started on a fourteen-hour drive to WordCamp US in 2018, when two Montclair meetup organizers came up with a name and then didn&#8217;t write any code for nine months. <strong>Rae Morey</strong> tells the story of <a href="https://www.therepository.email/how-gatherpress-grew-from-a-road-trip-idea-to-wordpress-meetup-com-replacement"><strong>how it grew into WordPress&#8217; Meetup.com replacement</strong></a>, through July of this year, when Automattic&#8217;s <strong>Karen Arnold</strong> confirmed WordPress is going ahead with it. The gatherpress.org domain is transferring to the Foundation, and the plugin has been testable at events.wordpress.org since August 28. No launch date yet, and co-maintainer <strong>Mervin Hernandez Sitnikovski</strong> would rather you help than wait.</p>



<h2 class="wp-block-heading" id="2-word-press-6-0-1-and-6-1-scheduled">Theme Development for Full Site Editing and Blocks</h2>



<p class="wp-block-paragraph">WooCommerce has a new block theme. <strong>Brian Coords</strong> announced that <a href="https://developer.woocommerce.com/2026/09/15/purple/"><strong>Purple is back and ready for beta testing</strong></a>. The project was paused during a strategy update last year, and it&#8217;s Woo&#8217;s first official block theme. </p>



<figure class="wp-block-image size-full has-custom-border"><img alt="" class="has-border-color has-accent-6-border-color wp-image-47183" height="1708" src="https://i0.wp.com/gutenbergtimes.com/wp-content/uploads/2026/09/purple-frontpage.jpg?resize=2048%2C1708&#038;ssl=1" style="border-width: 1px;" width="2048" /></figure>



<p class="wp-block-paragraph">Ten color palettes, ten font pairings, custom styles for both WooCommerce and core blocks, and templates covering everything from Shop to Checkout to My Account. The inserter category is being renamed from &#8220;WooCommerce&#8221; to &#8220;Shop.&#8221; If you&#8217;re wondering where Storefront&#8217;s featured extensions went, block editing absorbed most of them. <strong>Peter Schimke</strong> also notes that <a href="https://wordpress.com/blog/2026/09/16/purple-woocommerce-theme/"><strong>Purple is now the default for new WordPress.com Commerce stores</strong></a>.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<p class="wp-block-paragraph">Mark your calendar for <strong>Wednesday, September 30 at 10 a.m. PDT / 1 p.m. EDT / 7 p.m. CEST</strong>: Woo is hosting a live session on <a href="https://developer.woocommerce.com/2026/09/17/block-theme-event/"><strong>building with WooCommerce block themes</strong></a>. <strong>Mike McAlister</strong> of Ollie joins Woo engineers <strong>Karol Manijak</strong> and <strong>Lucio Giannotta</strong>. There&#8217;s a Q&amp;A at the end and a recording afterward, but questions only work if you show up.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<p class="wp-block-paragraph">&#8220;We need more workflow in Core,&#8221; said <strong>K. Adam White</strong>, principal engineer at Human Made, talking with <strong>Nathan Wrigley</strong> on WP Tavern about <a href="https://wptavern.com/podcast/234-k-adam-white-on-migrating-to-blocks-with-artisanal-care-and-enterprise-efficiency"><strong>migrating to blocks with artisanal care and enterprise efficiency</strong></a>. At the center of it is Human Made&#8217;s open-source <strong>Rehydrator</strong>, which uses pattern HTML as a template and injects migrated content into it, so structure and styling survive a move off something like Sitecore. He describes building SQLite databases from client exports just to find the edge cases. He&#8217;s candid about the gaps, too: granular permissions, editorial approval workflows, and internationalization.</p>


<div class="wp-block-newsletterglue-showhide ng-block" width="100%">
<figure class="wp-block-embed is-type-rich is-provider-pocket-casts wp-block-embed-pocket-casts"><div class="wp-block-embed__wrapper">

</div></figure>
</div>

<table cellpadding="0" cellspacing="0" class="ng-block-54044a96e597ad21 wp-block-newsletterglue-container ng-block" style="color: #666666;" width="100%">
<tbody>
<tr>
<td class="ng-block-vs ng-block-vs-1" colspan="3" height="0" style="height: 0px;"></td>
</tr>
<tr>
<td class="ng-block-hs ng-block-hs-1" height="0" style="width: 0px;"></td>
<td align="none" class="ng-block-td" style="font-size: 16px; font-family: Helvetica; line-height: 1.6; font-weight: normal; padding-top: 20px; padding-bottom: 20px; padding-left: 0px; padding-right: 0px; text-align: none; color: #666666; background-color: #fdfcea; border-radius: 12px;">
<table cellpadding="0" cellspacing="0" class="wp-block-newsletterglue-text ng-block" style="color: #666666;" width="100%">
<tbody>
<tr>
<td align="none" class="ng-block-td" style="font-size: 16px; font-family: Helvetica; line-height: 1.6; font-weight: normal; padding-top: 8px; padding-bottom: 10px; padding-left: 20px; padding-right: 20px; text-align: none; color: #666666;">
<p><strong> <a href="https://make.wordpress.org/core/handbook/references/keeping-up-with-gutenberg-index/" rel="noreferrer noopener" target="_blank">&#8220;Keeping up with Gutenberg &#8211; Index 2026&#8221;</a> </strong><br />A chronological list of the WordPress Make Blog posts from various teams involved in Gutenberg development: Design, Theme Review Team, Core Editor, Core JS, Core CSS, Test, and Meta team from Jan. 2024 on. Updated by yours truly. </p>
</td>
</tr>
</tbody>
</table>
<table cellpadding="0" cellspacing="0" class="wp-block-newsletterglue-text ng-block" style="color: #666666;" width="100%">
<tbody>
<tr>
<td align="none" class="ng-block-td" style="font-size: 16px; font-family: Helvetica; line-height: 1.6; font-weight: normal; padding-top: 8px; padding-bottom: 10px; padding-left: 20px; padding-right: 20px; text-align: none; color: #666666;">
<p>The previous years are also available: <br /><strong><strong><a href="https://make.wordpress.org/core/handbook/references/keeping-up-with-gutenberg-index/keeping-up-with-gutenberg-index-2020/">2020</a> | <a href="https://make.wordpress.org/core/handbook/references/keeping-up-with-gutenberg-index/keeping-up-with-gutenberg-index-2021/">2021</a></strong> | <strong><a href="https://make.wordpress.org/core/handbook/references/keeping-up-with-gutenberg-index/keeping-up-with-gutenberg-index-2022/">2022</a></strong></strong> | <strong><a href="https://make.wordpress.org/core/handbook/references/keeping-up-with-gutenberg-index/gutenberg-index-2023">2023</a></strong> | <a href="https://make.wordpress.org/core/handbook/references/keeping-up-with-gutenberg-index/gutenberg-index-2024/"><strong>2024</strong></a> | <strong><a href="https://make.wordpress.org/core/handbook/references/keeping-up-with-gutenberg-index/gutenberg-index-2025/">2025</a></strong></p>
</td>
</tr>
</tbody>
</table>
</td>
<td class="ng-block-hs ng-block-hs-2" height="0" style="width: 0px;"></td>
</tr>
<tr>
<td class="ng-block-vs ng-block-vs-2" colspan="3" height="0" style="height: 0px;"></td>
</tr>
</tbody>
</table>


<h2 class="wp-block-heading" id="3-building-themes-for-fse-and-word-press">Building Blocks and Tools for the Block editor</h2>



<p class="wp-block-paragraph"><em>Your Query Loop returns nothing, and the heading and pagination you wrapped around it render anyway. </em><strong>Ryan Welcher</strong> spent a live stream <a href="https://www.youtube.com/watch?v=RaW-0fsXVBM"><strong>adding a &#8220;hide if empty&#8221; control to Advanced Query Loop</strong></a>, his free plugin that extends the core Query Loop with taxonomy relationships, meta queries, and relative date filters.</p>


<div class="wp-block-newsletterglue-showhide ng-block" width="100%">
<figure class="wp-block-embed is-type-video is-provider-youtube wp-block-embed-youtube wp-embed-aspect-16-9 wp-has-aspect-ratio"><div class="wp-block-embed__wrapper">

</div></figure>
</div>


<hr class="wp-block-separator has-alpha-channel-opacity" />



<p class="wp-block-paragraph">Gutenberg&#8217;s JavaScript tests have moved off Jest. <strong>Marco Ciampini</strong> explains that <a href="https://make.wordpress.org/core/2026/09/23/gutenbergs-javascript-unit-and-integration-tests-now-use-vitest/"><strong>unit and integration tests now use Vitest</strong></a>, driven by ESM: as more dependencies shipped ECMAScript modules, the CommonJS-based Jest setup needed more and more compatibility glue. The part that affects you: @wordpress/scripts 36.0.0 makes Vitest the default for test-unit-js, with @wordpress/eslint-plugin 27.0.0 following. Not ready to migrate? Switch to wp-scripts test-unit-jest and install the Jest dependencies yourself.</p>



<h2 class="wp-block-heading" id="ai-in-wordpress"><strong>AI in WordPress</strong></h2>



<p class="wp-block-paragraph">Your agent builds you a landing page, and then what? It sits in a chat log, or a folder, or a local dev server nobody else can reach. That&#8217;s the gap <strong>Spacefast</strong> is built for, and Automattic soft-launched it this week: <strong>Matt Mullenweg</strong> <a href="https://x.com/photomatt/status/2102877364296257558"><strong>announced it on X</strong></a>. The pitch is the last mile for agent output: publish from a conversation with Claude or ChatGPT, from <code>npx spacefast publish</code>, or from a GitHub push, and get a permanent URL with immutable versions, one-click rollback, and access controls. It hosts full-stack projects, not just static files.</p>



<p class="wp-block-paragraph">The WordPress hook is a <a href="https://github.com/spacefast/wordpress"><strong>Spacefast plugin</strong></a> with two modes. Static mode hooks into Simply Static, exports your site, and publishes the snapshot. Headless mode treats WordPress as the content source for a repository project, triggering a production rebuild when you publish or update public content.</p>



<h3 class="wp-block-heading" id="mcp-turns-up-everywhere"><strong>MCP turns up everywhere</strong></h3>



<p class="wp-block-paragraph">WordPress Trac now speaks MCP. <strong>Lance Willett</strong> announced a <a href="https://make.wordpress.org/core/2026/09/24/wordpress-trac-mcp-server/"><strong>Trac MCP server</strong></a> that&#8217;s &#8220;public and free to use: no account or API key needed.&#8221; Ask what&#8217;s left on a ticket and which pull requests are still open, or what someone committed in January 2005—<em>yes, it goes back that far</em>. It covers every WordPress.org Trac, from Core and Meta to bbPress and GlotPress. <strong>James LePage</strong> wrote the first version, with props to <strong>Jon Surrell</strong>, <strong>David Newman</strong>, and <strong>Konstantin Obenland</strong>.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<p class="wp-block-paragraph"><strong>Jamie Marsland</strong> makes the case for <a href="https://www.pootlepress.com/2026/09/why-webmcp-is-going-to-be-big-for-wordpress/"><strong>why WebMCP is going to be big for WordPress</strong></a> and, more usefully, shows you how to try it this afternoon: open the ChatGPT desktop app in Work mode, load WordPress Playground in its built-in browser, and ask it to build you a homepage. His framing is the clearest I&#8217;ve read. WebMCP gives an assistant &#8220;an instruction manual with working buttons&#8221; instead of making it squint at screenshots.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<p class="wp-block-paragraph">For the enterprise view of the same shift, <strong>Shane Schick</strong> compares <a href="https://wpvip.com/blog/webmcp-vs-traditional-mcp/"><strong>WebMCP and traditional MCP</strong></a> and lands on a line I&#8217;d pull out of the whole piece: &#8220;MCP is not going away, and WebMCP shouldn&#8217;t be seen as a rival protocol.&#8221; His table sets them side by side on deployment, access scope, scalability, and auditability. That auditability row is the one that matters if you answer to a compliance team.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<p class="wp-block-paragraph">Schick also introduces <a href="https://wpvip.com/blog/introducing-parse-ly-mcp/"><strong>Parse.ly MCP</strong></a>, which connects Parse.ly data to whichever assistant your team already uses. You authorize once with your existing login, and the assistant sees exactly the sites your account already sees. &#8220;Analysis that used to take a request and a day now takes a conversation.&#8221;</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<p class="wp-block-paragraph">One more, for the security-conscious: WPShout walks through <a href="https://wpshout.com/connect-cursor-to-wordpress-mcp/"><strong>connecting Cursor to WordPress with MCP</strong></a> using ThemeIsle&#8217;s Easy MCP AI plugin. Every tool call still passes a WordPress capability check, with a 60-requests-per-minute default. Their advice is the part to take seriously: &#8220;read-only first, watch the audit log for a week, then grant write scopes deliberately.&#8221;</p>



<h3 class="wp-block-heading" id="putting-agents-to-work"><strong>Putting agents to work</strong></h3>



<p class="wp-block-paragraph">Anthropic open-sourced its commerce agents on September 2, and WooCommerce has already adapted them. <strong>Shani Banerjee</strong> walks through <a href="https://developer.woocommerce.com/2026/09/16/wc-claude-commerce-agent/"><strong>running the Claude Commerce Agent on WooCommerce</strong></a>, which spins up a demo store with eight products and nine orders in about fifteen minutes. The neat piece is a bridge plugin: the assistant&#8217;s cart lives under a Store API token your browser session can&#8217;t see, so at checkout the plugin re-adds each item to your real cart with normal stock checks. Merchant-side changes stage behind an approval gate, and &#8220;ask it to approve itself and it declines.&#8221;</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<p class="wp-block-paragraph">There&#8217;s a second kind of visitor to design for now. <strong>Carlo Daniele</strong> argues for <a href="https://kinsta.com/blog/wordpress-for-ai-agents/"><strong>building WordPress for AI agents instead of just human visitors</strong></a>, and the distinction he draws is the useful one: &#8220;Crawlers primarily retrieve or index information. Agents can go a step further and take action on a user&#8217;s behalf.&#8221; That turns architecture questions into permission questions: who is asking, on whose behalf, what can they change, which actions need approval. The Abilities API and MCP Adapter are where WordPress answers them.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<p class="wp-block-paragraph">A week later, Daniele turned to operations. <a href="https://kinsta.com/blog/ai-wordpress-operators/"><strong>What happens when AI agents become your new website operators?</strong></a> works through a five-stage autonomy ladder and argues most teams should sit partway up it for a while. I feel like he&#8217;s right about that. As he puts it: &#8220;An agent that makes a bad production change creates another.&#8221;</p>



<h3 class="wp-block-heading" id="learning-and-practice"><strong>Learning and practice</strong></h3>



<p class="wp-block-paragraph">Want a structured introduction rather than a pile of blog posts? <strong>Destiny Kanno</strong> announced that the <a href="https://make.wordpress.org/ai/2026/09/18/xpost-the-ai-powered-wordpress-course-is-now-live-on-learn-wordpress/"><strong>AI-Powered WordPress course is now live on Learn WordPress</strong></a>: four modules, 23 lessons, roughly nine hours. The first three are for anyone who publishes; the fourth introduces the developer APIs and assumes no prior PHP experience.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<p class="wp-block-paragraph">The AI team&#8217;s <a href="https://make.wordpress.org/ai/2026/09/16/ai-contributor-weekly-summary-16-september-2026/"><strong>contributor summary for September 16</strong></a> is a good snapshot of what&#8217;s actually moving. <strong>neillmcshea</strong> reports work on markdown feeds for the AI plugin, so AI clients can request a markdown version of a post. PHP AI Client 1.5.0 is close. There are still open gaps in web search support. For example, message parts can&#8217;t represent source annotations, and citation URLs are hard to retrieve.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<p class="wp-block-paragraph">Finally, a piece for the conversations you have with clients rather than with a terminal. <strong>Will Davis</strong> writes about <a href="https://humanmade.com/ai/how-wordpress-agencies-use-ai-and-what-clients-should-ask/"><strong>how WordPress agencies use AI, and what clients should ask about it</strong></a>, arguing that the honest uses are the boring ones—code generation, QA, content migration, documentation—while architecture and governance stay human. His five questions for clients would work just as well on a sales call, starting with &#8220;What does a person review before it reaches me?&#8221; As he puts it, AI &#8220;genuinely reduces repetitive work, but it doesn&#8217;t replace judgment.&#8221;</p>


<table cellpadding="0" cellspacing="0" class="ng-block-b80aa159c0a1ae04 wp-block-newsletterglue-container ng-block" style="color: #666666;" width="100%">
<tbody>
<tr>
<td class="ng-block-vs ng-block-vs-1" colspan="3" height="0" style="height: 0px;"></td>
</tr>
<tr>
<td class="ng-block-hs ng-block-hs-1" height="0" style="width: 0px;"></td>
<td align="none" class="ng-block-td" style="font-size: 16px; font-family: Helvetica; line-height: 1.6; font-weight: normal; padding-top: 20px; padding-bottom: 20px; padding-left: 0px; padding-right: 0px; text-align: none; color: #666666; background-color: #f8f8f8; border-radius: 8px;">
<table cellpadding="0" cellspacing="0" class="wp-block-newsletterglue-text ng-block" style="color: #666666;" width="100%">
<tbody>
<tr>
<td align="none" class="ng-block-td" style="font-size: 16px; font-family: Helvetica; line-height: 1.6; font-weight: normal; padding-top: 8px; padding-bottom: 10px; padding-left: 20px; padding-right: 20px; text-align: none; color: #666666;">
<p><strong><a href="https://gutenbergtimes.com/need-a-zip-from-master/">Need a plugin .zip from Gutenberg&#8217;s master branch?</a></strong><br />Gutenberg Times provides daily build for testing and review.</p>
</td>
</tr>
</tbody>
</table>
<table cellpadding="0" cellspacing="0" class="wp-block-newsletterglue-image ng-block size-full is-resized" width="100%">
<tbody>
<tr>
<td align="center" class="ng-block-td" style="padding-top: 0px; padding-bottom: 0px; padding-left: 0px; padding-right: 0px;"><a href="https://playground.wordpress.net/?blueprint-url=https://gutenbergtimes.com/wp-content/uploads/2020/11/playnightly.json"><img alt="" class="wp-image-42874 ng-image" height="45" src="https://i0.wp.com/gutenbergtimes.com/wp-content/uploads/2024/02/Screenshot-2025-11-15-at-12.06.44.png?resize=196%2C45&#038;ssl=1" style="border-style: none; border-color: transparent;" width="196" /></a></td>
</tr>
</tbody>
</table>
<table cellpadding="0" cellspacing="0" class="wp-block-newsletterglue-text ng-block" style="color: #666666;" width="100%">
<tbody>
<tr>
<td align="none" class="ng-block-td" style="font-size: 16px; font-family: Helvetica; line-height: 1.6; font-weight: normal; padding-top: 8px; padding-bottom: 10px; padding-left: 20px; padding-right: 20px; text-align: none; color: #666666;">
<p>Now also available via <a href="https://playground.wordpress.net/?blueprint-url=https://gutenbergtimes.com/wp-content/uploads/2020/11/playnightly.json">WordPress Playground</a>. There is no need for a test site locally or on a server. Have you been using it? <a href="mailto:pauli@gutenbergtimes.com">Email me </a>with your experience.</p>
</td>
</tr>
</tbody>
</table>
</td>
<td class="ng-block-hs ng-block-hs-2" height="0" style="width: 0px;"></td>
</tr>
<tr>
<td class="ng-block-vs ng-block-vs-2" colspan="3" height="0" style="height: 0px;"></td>
</tr>
</tbody>
</table>


<hr class="wp-block-separator has-alpha-channel-opacity is-style-wide is-style-wide--1" />



<p class="has-text-align-center has-small-font-size wp-block-paragraph"><em>Questions? Suggestions? Ideas? </em><br /><em>Don&#8217;t hesitate to send <a href="mailto:pauli@gutenbergtimes.com">them via email</a> or</em><br /><em> send me a message on WordPress Slack or Twitter @bph</em>.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<p class="has-text-align-center has-small-font-size wp-block-paragraph">For questions to be answered on the <a href="http://gutenbergtimes.com/podcast">Gutenberg Changelog</a>, <br />send them to <a href="mailto:changelog@gutenbergtimes.com">changelog@gutenbergtimes.com</a></p>


<div class="ng-block-e7035f00e2f26803 wp-block-newsletterglue-separator ng-block" style="color: #666666;" width="100%"><div><div><div align="center" class="ng-block-td" style="padding-top: 20px; padding-bottom: 20px; padding-left: 20px; padding-right: 20px; color: #666666;"><hr style="background-color: transparent; color: transparent; margin: 0; border: 0; border-top: 1px solid #666666; width: 560px; height: 0;" /></div></div></div></div>




<hr class="wp-block-separator has-alpha-channel-opacity is-style-wide is-style-wide--2" />";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sat, 26 Sep 2026 16:45:09 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Justin Tadlock";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:32;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:40:"Dennis Snell: Enter the mess: Shortcodes";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:36:"https://fluffyandflakey.blog/?p=4130";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:66:"https://fluffyandflakey.blog/2026/09/25/enter-the-mess-shortcodes/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1005:"<p class="wp-block-paragraph">Tonight I started working on some Shortcode processing in WordPress. This is an historically nasty problem because the Shortcode syntax and parsing is wildly dynamic.</p>



<ul class="wp-block-list">
<li>Shortcode syntax is only technically recognized for shortcodes registered at the time of parsing. This means that there is not a general Shortcode grammar.</li>



<li>Whether a shortcode has “content,” meaning whether it expects a closing tag, depends on whether the closing tag <em>exists</em> in the post.</li>
</ul>



<p class="wp-block-paragraph">This is a problem that has plagued me for years and I have generally just ignored. There’s an open Core issue in Trac for changing some shortcode parsing (<a href="https://core.trac.wordpress.org/ticket/50683">#50683</a>), and I have thought a lot about it.</p>



<p class="wp-block-paragraph">But I think there is more to explore, and more to gain. Maybe this goes nowhere, but keep your eyes open for it.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Sat, 26 Sep 2026 02:43:45 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Dennis Snell";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:33;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:71:"Open Channels FM: Your Website Could Use a Changelog to Fuel Creativity";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2562622";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:78:"https://openchannels.fm/your-website-could-use-a-changelog-to-fuel-creativity/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:220:"A website changelog helps creators document progress, celebrate small wins, showcase evolution, fuel creativity, and build audience trust. It can include updates, humor, and various formats, making it accessible for all.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 25 Sep 2026 13:44:23 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:3:"Bob";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:34;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:94:"Open Channels FM: Is It Time to Move On?  Navigating Change and Letting Go in Fast-Paced Times";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2562603";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:99:"https://openchannels.fm/is-it-time-to-move-on-navigating-change-and-letting-go-in-fast-paced-times/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:101:"A reflection on recognizing the right time to move on from creative projects and handling self-doubt.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 25 Sep 2026 12:30:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"Bob Dunn";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:35;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:100:"OpenStation Blog: “I can’t imagine using WordPress any other way”: the love behind OpenStation";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"https://openstation.blog/?p=1306";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:109:"https://openstation.blog/2026/09/25/i-cant-imagine-using-wordpress-any-other-way-the-love-behind-openstation/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:8731:"<figure class="wp-block-image size-large"><img alt="A digital workspace interface displaying various applications, including a note-taking feature, recent comments section, and post statistics, alongside a scenic background featuring a rider on horseback in a vast landscape." class="wp-image-1308" height="568" src="https://i0.wp.com/openstation.blog/wp-content/uploads/2026/09/HS_NADgXsAABwZg.jpeg?resize=1024%2C568&#038;ssl=1" width="1024" /></figure>



<p class="wp-block-paragraph"><strong>OPENSTATION · COMMUNITY VOICES</strong></p>



<p class="wp-block-paragraph"><em>Formerly Desktop Mode, now a new way to feel at home in wp-admin.</em></p>



<p class="wp-block-paragraph">A plugin can accumulate installs. It is rarer for people to describe it as a new way of thinking. As of September 25, 2026, OpenStation, known in its earliest releases as Desktop Mode, has inspired <strong>23 public WordPress.org reviews: 22 five-star and one four-star</strong>.</p>



<p class="wp-block-paragraph">OpenStation turns the WordPress admin into a spatial workspace: movable windows, a dock, a taskbar, widgets and virtual desktops. That is the feature list. The feeling is better told by the people who use it.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<h2 class="wp-block-heading">The words that stopped us in our tracks</h2>



<h3 class="wp-block-heading">1. When a plugin becomes the default</h3>



<blockquote class="wp-block-quote is-layout-flow wp-block-quote-is-layout-flow">
<p class="wp-block-paragraph">“I can’t imagine using WordPress any other way. I love this plugin so much.”</p>
</blockquote>



<p class="wp-block-paragraph"><em>— Nick Hamze, <a href="https://wordpress.org/support/topic/favorite-plugin-ever-2/">“Favorite plugin ever”</a></em></p>



<p class="wp-block-paragraph">That may be the highest compliment a tool can earn: not merely useful, but difficult to imagine living without. Nick’s review reads less like a rating and more like an invitation to join a movement.</p>



<blockquote class="wp-block-quote is-layout-flow wp-block-quote-is-layout-flow">
<p class="wp-block-paragraph">“This is a game-changer. Can never go back!”</p>
</blockquote>



<p class="wp-block-paragraph"><em>— ainom, <a href="https://wordpress.org/support/topic/absolute-pure-awesomeness/">“Absolute pure awesomeness”</a></em></p>



<p class="wp-block-paragraph">OpenStation begins as a striking visual idea, then quietly rewires expectations. Once several admin screens can live together, the old one-page-at-a-time flow feels surprisingly distant.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<h3 class="wp-block-heading">2. When the metaphor improves the work</h3>



<blockquote class="wp-block-quote is-layout-flow wp-block-quote-is-layout-flow">
<p class="wp-block-paragraph">“It genuinely feels like using a lightweight operating system inside WordPress.”</p>
</blockquote>



<p class="wp-block-paragraph"><em>— spackenjaeger, <a href="https://wordpress.org/support/topic/a-revolutionary-new-wordpress-admin-experience/">“A revolutionary new WordPress admin experience”</a></em></p>



<p class="wp-block-paragraph">The operating-system metaphor is not decoration. Windows hold context. The dock makes tools reachable. Virtual desktops separate kinds of work. The familiar desktop grammar turns multitasking into something visible and natural.</p>



<blockquote class="wp-block-quote is-layout-flow wp-block-quote-is-layout-flow">
<p class="wp-block-paragraph">“Having several admin screens open at once changed how I work more than I expected.”</p>
</blockquote>



<p class="wp-block-paragraph"><em>— Juan Lentino, <a href="https://wordpress.org/support/topic/renamed-its-entire-public-api-without-breaking-a-single-integration-point-2/">production user and plugin integrator</a></em></p>



<p class="wp-block-paragraph">Juan’s review is especially telling: he has run OpenStation in production since the Desktop Mode days and builds integrations against it. The novelty faded; the workflow remained.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<h3 class="wp-block-heading">3. When delight becomes productive</h3>



<blockquote class="wp-block-quote is-layout-flow wp-block-quote-is-layout-flow">
<p class="wp-block-paragraph">“The desktop-style layout, draggable windows, dock, and taskbar make the admin area feel completely different in the best way.”</p>
</blockquote>



<p class="wp-block-paragraph"><em>— Marco Moreira, <a href="https://wordpress.org/support/topic/a-refreshing-new-way-to-use-wordpress-admin/">“A refreshing new way to use WordPress admin”</a></em></p>



<p class="wp-block-paragraph">Productivity software does not have to be joyless. The best interfaces reduce friction and add a little momentum, the feeling that the workspace is helping rather than merely waiting.</p>



<blockquote class="wp-block-quote is-layout-flow wp-block-quote-is-layout-flow">
<p class="wp-block-paragraph">“This plugin blowed my mind. It turns your wordpress admin in such a beautiful dashboard. What an experience.”</p>
</blockquote>



<p class="wp-block-paragraph"><em>— MauroS, <a href="https://wordpress.org/support/topic/one-word-wow-7/">“One word… Wow!”</a></em></p>



<p class="wp-block-paragraph">The wording is wonderfully unfiltered. Beauty, surprise and experience are not side effects here; they are part of the product.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<h3 class="wp-block-heading">4. When people see the road ahead</h3>



<blockquote class="wp-block-quote is-layout-flow wp-block-quote-is-layout-flow">
<p class="wp-block-paragraph">“This is definitely something I would use on a daily basis. Well done!”</p>
</blockquote>



<p class="wp-block-paragraph"><em>— vepth, <a href="https://wordpress.org/support/topic/im-blown-away-3/">“I’m blown away”</a></em></p>



<blockquote class="wp-block-quote is-layout-flow wp-block-quote-is-layout-flow">
<p class="wp-block-paragraph">“Desktop Mode definitely stands out with its own approach.”</p>
</blockquote>



<p class="wp-block-paragraph"><em>— Rami Obeidat, <a href="https://wordpress.org/support/topic/modern-and-creative-admin-experience/">“Modern and creative admin experience”</a></em></p>



<p class="wp-block-paragraph">Both reviews point to the same achievement: OpenStation is not chasing a generic “modern admin” look. It has a point of view—spatial, extensible and unmistakably its own.</p>



<hr class="wp-block-separator has-alpha-channel-opacity" />



<h2 class="wp-block-heading">From Desktop Mode to OpenStation</h2>



<p class="wp-block-paragraph">The project’s name changed because its ambition outgrew a mode. “Desktop Mode” described the first transformation. <strong>OpenStation</strong> describes the platform emerging around it: a place where WordPress apps, windows, widgets and workflows can meet.</p>



<blockquote class="wp-block-quote is-layout-flow wp-block-quote-is-layout-flow">
<p class="wp-block-paragraph">“The integration surface is unusually well behaved for a plugin this ambitious.”</p>
</blockquote>



<p class="wp-block-paragraph"><em>— Juan Lentino, <a href="https://wordpress.org/support/topic/renamed-its-entire-public-api-without-breaking-a-single-integration-point-2/">WordPress.org reviewer and integrator</a></em></p>



<p class="wp-block-paragraph">That sentence matters as much as the praise for the interface. The magic users see is supported by a public API that plugin authors can build on, frequent releases and an opt-in design that keeps classic WordPress one click away.</p>



<h2 class="wp-block-heading">The best roadmap is a chorus</h2>



<p class="wp-block-paragraph">Names change. Interfaces evolve. Code ships, breaks, improves and ships again. What stays constant in these reviews is the feeling that WordPress can be more personal, more spatial and more alive.</p>



<p class="wp-block-paragraph"><strong>OpenStation is still moving fast.</strong> But if the people already living in it are any guide, the destination is worth watching, and the journey is already changing how they work.</p>



<p class="wp-block-paragraph"><a href="https://github.com/WordPress/openstation"><strong>Explore OpenStation on GitHub →</strong></a><br /><a href="https://wordpress.org/support/plugin/desktop-mode/reviews/"><strong>Read all WordPress.org reviews →</strong></a></p>



<p class="wp-block-paragraph"><small>Quotes are excerpted from public WordPress.org reviews. Spelling is preserved; excerpts are linked to their original sources.</small></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 25 Sep 2026 11:33:33 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Daniel López";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:36;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:31:"Matt: Bruce Schneier on Systems";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:23:"https://ma.tt/?p=155048";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:31:"https://ma.tt/2026/09/schneier/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:460:"<figure class="wp-block-embed alignwide is-type-video is-provider-youtube wp-block-embed-youtube wp-embed-aspect-16-9 wp-has-aspect-ratio"><div class="wp-block-embed__wrapper">

</div></figure>



<p class="wp-block-paragraph">Bruce is one of my favorite writers. He packs profoundness. Also honored that he&#8217;s an advisor at <a href="https://automattic.com/">Automattic</a>, truly one of my idols. His blogs and books rocked my world when I was young.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 25 Sep 2026 07:04:50 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:4:"Matt";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:37;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:76:"Open Channels FM: How Generational Perspectives Shape Our Digital Work Lives";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2562342";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:83:"https://openchannels.fm/how-generational-perspectives-shape-our-digital-work-lives/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:114:"Cami and Bob talk about adapting to tech changes growing older in the web industry and keeping routines that work.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 24 Sep 2026 14:30:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"Bob Dunn";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:38;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:109:"Open Channels FM: Navigating Support Systems from the Man Cold to Open Source and WordPress Open Web Alliance";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2562536";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:116:"https://openchannels.fm/navigating-support-systems-from-the-man-cold-to-open-source-and-wordpress-open-web-alliance/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:132:"Examining support systems behind open source, the open web, and everyday life, along with why sustaining these efforts is necessary.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Thu, 24 Sep 2026 13:02:50 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"Bob Dunn";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:39;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:53:"Open Channels FM: The Podcast Open Makers is Archived";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2562154";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:60:"https://openchannels.fm/the-podcast-open-makers-is-archived/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:221:"The podcast network has reduced its active lineup to four shows, leading to no new episodes for Open Makers. However, past content remains accessible, with a shift towards deeper discussions on open source and web trends.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 23 Sep 2026 13:00:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:3:"Bob";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:40;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:101:"WPTavern: #234 – K. Adam White on Migrating to Blocks With Artisanal Care and Enterprise Efficiency";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:48:"https://wptavern.com/?post_type=podcast&p=208362";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:114:"https://wptavern.com/podcast/234-k-adam-white-on-migrating-to-blocks-with-artisanal-care-and-enterprise-efficiency";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:53882:"<details>Transcript<div>
<p class="wp-block-paragraph">[00:00:19] <strong>Nathan Wrigley:</strong> Welcome to the Jukebox Podcast from WP Tavern. My name is Nathan Wrigley.</p>



<p class="wp-block-paragraph">Jukebox is a podcast which is dedicated to all things WordPress. The people, the events, the plugins, the blocks, the themes, and in this case, migrating to blocks at an enterprise level and what&#8217;s involved in moving from a different CMS into WordPress.</p>



<p class="wp-block-paragraph">If you&#8217;d like to subscribe to the podcast, you can do that by searching for WP Tavern in your podcast player of choice, or by going to wptavern.com/feed/podcast, and you can copy that URL into most podcast players.</p>



<p class="wp-block-paragraph">If you have a topic that you&#8217;d like us to feature on the podcast, I&#8217;m keen to hear from you and hopefully get you, or your idea, featured on the show. Head to wptavern.com/contact/jukebox and use the form there.</p>



<p class="wp-block-paragraph">So on the podcast today, we have K. Adam White, or K. Adam for short.  K. Adam is the principal engineer at Human Made, an enterprise WordPress consultancy. He&#8217;s been involved with WordPress for almost 20 years, attending his first WordCamp in Boston back in 2011, and has contributed to WordPress Core and the broader open source ecosystem. Human Made is known for delivering complex projects, think high stakes, no room for mistakes? From global brands moving to WordPress.</p>



<p class="wp-block-paragraph">This time around,  K. Adam delivered a presentation at WordCamp US focused on a crucial topic for anyone modernising their site, migrating to blocks. Human Made has been all in on the block editor since the Gutenberg plugin days, and the team now specialises in large scale migrations from other content management systems like Sitecore, as well as from other WordPress page builders.</p>



<p class="wp-block-paragraph">Our conversation focused on the technical and editorial challenges of moving tens, or hundreds, of thousands of posts into the world of blocks and patterns. We talked about the need to combine artisanal care, attention to detail in design, layout, and brand, with industrial scale. The ability to automate, audit and validate mass migrations without losing visual fidelity.</p>



<p class="wp-block-paragraph">We also discussed the use of patterns as a foundation for development, integrating custom and Core blocks, and leveraging new tools, including AI powered agents and open source plugins like Human Made&#8217;s, own rehydrator, to streamline migration workflows.</p>



<p class="wp-block-paragraph">We also touched upon how clients are onboarded. The process of auditing legacy content. Strategies for training editorial teams on the block editor. And there&#8217;s a frank reflection on gaps in WordPress, like granular content permissions.</p>



<p class="wp-block-paragraph">If you are contemplating a move to the block editor, wrestling with a massive content migration, or curious about what happens when enterprise complexity meets the flexibility of WordPress, this episode is for you.</p>



<p class="wp-block-paragraph">If you&#8217;re interested in finding out more, you can find all of the links in the show notes by heading to wptavern.com/podcast, where you&#8217;ll find all the other episodes as well.</p>



<p class="wp-block-paragraph">And so without further delay, I bring you  K. Adam White.</p>



<p class="wp-block-paragraph">I am joined on the podcast by K. Adam White. Hello, K. Adam.</p>



<p class="wp-block-paragraph">[00:03:41] <strong>K. Adam White:</strong> Hello. It&#8217;s good to be here.</p>



<p class="wp-block-paragraph">[00:03:42] <strong>Nathan Wrigley:</strong> Yeah. Thank you for joining us. You have an interesting name. Just go on, I know it&#8217;s totally off piste, but tell us about your name.</p>



<p class="wp-block-paragraph">[00:03:49] <strong>K. Adam White:</strong> Sure. It&#8217;s a first initial K, and the middle name Adam that got conjoined in college and I quite like it. So I think in a sphere, and a particular niche in WordPress with so many Adams of so many different colours, then K. Adam is a little bit more me.</p>



<p class="wp-block-paragraph">[00:04:04] <strong>Nathan Wrigley:</strong> Yeah, nice. So we&#8217;re in the corridor, so forgive any noise that you hear on this podcast episode. We can&#8217;t avoid it. We&#8217;re in the corridor at  WordCamp US, and you have done, some presentation work this time around. Do you want to just tell us, I mean I presume it&#8217;s happened because we&#8217;re at the very closing stages of the conference. How did it go?</p>



<p class="wp-block-paragraph">[00:04:21] <strong>K. Adam White:</strong> It went, as far as I can tell, quite well. My session was early yesterday, right after the morning keynotes in that early slot where everyone&#8217;s coffee has kicked in, and the fatigue of the conference hasn&#8217;t quite set in yet.</p>



<p class="wp-block-paragraph">So I had a great audience and the talk I thing went quite well. I&#8217;ve had a number of different conversations off the back of it on various different topics that I covered. So the breadth of those discussions has been really exciting for me.</p>



<p class="wp-block-paragraph">[00:04:44] <strong>Nathan Wrigley:</strong> So that is going to be the meat and the bones of what we&#8217;re going to talk about today. But first, if you don&#8217;t mind, let&#8217;s talk a little bit about you and what you do and where you work, just so that we can paint your credentials if you like.</p>



<p class="wp-block-paragraph">So tell us about your job, how long you&#8217;ve been in the WordPress space? Who do you work for? Et cetera.</p>



<p class="wp-block-paragraph">[00:04:59] <strong>K. Adam White:</strong> Yeah. My job is principal engineer at Human Made. We&#8217;re a WordPress enterprise consultancy, and I have been there nine years. I&#8217;ve been in the WordPress community quite a lot longer than that. My first WordCamp was WordCamp Boston 2011, which is a mind boggling 15 years ago now. And before that, I had been using WordPress personally since 2007. So we&#8217;re coming up on 20 years of involvement, at least as a user. And then, became a contributor in the early 2010s around 2013, I think my first commit landed.</p>



<p class="wp-block-paragraph">[00:05:25] <strong>Nathan Wrigley:</strong> Yeah, nice and Human Made, if you haven&#8217;t heard, we&#8217;ll put the links into the show notes, anything that K. Adam mentions today, we will put us a link on the WP Tavern podcast episode website, so you can click through to it. But go and check out Human Made, definitely one of the big hitters. I think it&#8217;s fair to say in the WordPress space.</p>



<p class="wp-block-paragraph">[00:05:40] <strong>K. Adam White:</strong> It&#8217;s very kind of you to say so.</p>



<p class="wp-block-paragraph">[00:05:42] <strong>Nathan Wrigley:</strong> You did your presentation and it was entitled, Migrating to Blocks. I&#8217;m going to intuit from that, that Human Made is all in on the block editor. You&#8217;re not using some sort of other proprietary platform. Would that be the case?</p>



<p class="wp-block-paragraph">[00:05:55] <strong>K. Adam White:</strong> That would be the case. We were very early adopters of Gutenberg back in its plugin days. We were doing work before it was merged for building out some early block sites, testing out what we could do. Learning how to build and change our theme development processes to move in a more block oriented direction, and then follow that directly into the Full Site Editor world.</p>



<p class="wp-block-paragraph">And it&#8217;s been a great ride. We do work with other page builders and other blocks, platforms and frameworks. We do tend to, as a company, work on projects that have some sort of particular technical complexity that made someone come to us rather than a different agency.</p>



<p class="wp-block-paragraph">That does mean that we are broadly specialised in WordPress as a platform, including many of those page builders. We&#8217;ve worked with Elementor, we&#8217;ve worked with Divi, Beaver Builder, but we as a company will always advocate for the block editor and the site editor. And we have our own processes oriented more and more towards delivery with that framework in mind.</p>



<p class="wp-block-paragraph">I think that the thing that is bringing some of the companies that we help to migrate to WordPress into this ecosystem is the flexibility and the quality of the editorial experience. And personally, my opinion is that Gutenberg does that leaps and bounds better than any of our other page builders that don&#8217;t have that native integration into the platform.</p>



<p class="wp-block-paragraph">[00:07:09] <strong>Nathan Wrigley:</strong> So if a client comes to you and they are agnostic as to what you are going to build with, your default posture would be we are going to use the block editor.</p>



<p class="wp-block-paragraph">[00:07:16] <strong>K. Adam White:</strong> Absolutely default.</p>



<p class="wp-block-paragraph">[00:07:17] <strong>Nathan Wrigley:</strong> Okay. And do you have to do any level of persuasion anymore? I&#8217;m guessing if we were to rewind the clock, let&#8217;s go to 2017, soon after Gutenberg started to become more widely available. I imagine there was quite a bit of explaining to do. Do you still have to do any of that? Or is it a case now that the enterprise people understand what&#8217;s going on, and there&#8217;s less of a back and forth about whether they should use blocks and patterns and whatever else?</p>



<p class="wp-block-paragraph">[00:07:41] <strong>K. Adam White:</strong> If we are building from scratch, we haven&#8217;t found there is any reluctance. Particularly if people are coming from a different content management system, particularly a different enterprise content management system. The editor is so compelling, that there&#8217;s never any objection to using it. They might ask, should we use this or some other thing I&#8217;ve heard of? And we can say, the block editor is built in. We feel that it&#8217;s the most robust and future proof platform that you can choose. So we would recommend going that route rather than adding in another plugin, however good they are.</p>



<p class="wp-block-paragraph">But we do still, nonetheless, have some projects where they are already on a page builder, and they might have invested a lot of training. We might have an entire business school worth of people that are very comfortable with whatever their existing system is, whether that&#8217;s Beaver Builder or something else, et cetera, Elementor.</p>



<p class="wp-block-paragraph">And I think that it&#8217;s very important for us to remember what our remit is when we come into a project. That, doesn&#8217;t always involve helping them change everything to match what we see as the future. I think that&#8217;s a responsibility of the client to understand where they are in conjunction with where the WordPress roadmap is, and make their own decisions about what tools are right for them.</p>



<p class="wp-block-paragraph">So, for existing projects, we&#8217;ll work with what&#8217;s right for the clients editorial team, but if we have to make a recommendation, it will always be the block editor.</p>



<p class="wp-block-paragraph">[00:08:56] <strong>Nathan Wrigley:</strong> Okay. Yeah, good to know. At place in the market where you are, I&#8217;m presuming there&#8217;s very little room for error. When you build something, it&#8217;s got to work out of the box, on day one. You&#8217;ve presumably got stakeholders who&#8217;ve got editorial teams, and they&#8217;re fairly, we&#8217;re, dealing with large corporations that can&#8217;t afford for there to be mistakes.</p>



<p class="wp-block-paragraph">So that kind of leads us to the nature of your presentation, which was called, and again, links will be in the show notes on wptavern.com. Migrating to Blocks with Artisanal Care and Industrial Scale. And I&#8217;m actually just going to read the first paragraph because it summarises what we&#8217;re going to talk about perfectly. It&#8217;s fairly long, but I&#8217;ll go through it all.</p>



<p class="wp-block-paragraph">Whether we&#8217;re modernising an old personal blog or migrating hundreds of thousands of existing posts from another CMS. Using WordPress in 2026 means converting our contents to blocks. The convert to blocks button in the editor works well enough for one post. But if we have dozens or hundreds, what can we do to make the process less manual and more powerful? How can we integrate a site&#8217;s content directly into full block patterns without losing the columns and structure it had before? And then it goes on to mention, a particular build, I presume, where you were leaving one CMS coming into WordPress.</p>



<p class="wp-block-paragraph">Just lay out some of the fun, interesting problems that you have to overcome when you&#8217;re moving from an entirely different CMS into WordPress, because I guess it&#8217;s more complicated than, &#8220;Look, there&#8217;s a bunch of paragraphs and images. Let&#8217;s just drag those over and hope for the best.&#8221; Tell us what the problem before you is.</p>



<p class="wp-block-paragraph">[00:10:22] <strong>K. Adam White:</strong> That&#8217;s a great question. It&#8217;s actually remarkable how close you can get to satisfaction with just moving paragraphs and images over and hoping for the best. But there is a big gap in terms of visual fidelity.</p>



<p class="wp-block-paragraph">The editor in a theme that we&#8217;ve built for a client will be configured with patterns and templates and all of the block variations that they need to be able to very quickly sketch out a page. If they are starting from scratch, a client with a fully site editing enabled theme can drop a hero pattern on the page, set in the media they need. Change any font sizes within the pallet of what&#8217;s available with their brand guidelines encoded in the theme.json. It&#8217;s very easy for them to build out and write content fresh.</p>



<p class="wp-block-paragraph">But if you have, again, hundreds of thousands of posts, even if you&#8217;ve built all those patterns, the heading and paragraph and image only approach doesn&#8217;t cut it, because then there would be a tremendously backbreaking amount of work, adding group blocks, adding background colours, et cetera.</p>



<p class="wp-block-paragraph">That&#8217;s usually data that is available in one form or the other in the current system. If we&#8217;re migrating without a design change, we will have, whether it&#8217;s the layout database in Sitecore or a metadata in a different WordPress block editor that we&#8217;re migrating from. Or whatever the equivalent is in our source. We want to preserve the layout of the page and the styling elements. So making sure that headings get the right text treatment, that anything that&#8217;s italicised comes over. All of the nuances there, particularly around background colours, images, et cetera. That&#8217;s the piece that we&#8217;ve been over the past year, looking at how we can improve our process when we&#8217;re building a new site, but bringing content over from an old.</p>



<p class="wp-block-paragraph">Within that context, my talk covered two broad areas. The specific tail end of the talk was about how we can actually use the theme patterns that already exist in the theme directory, and use those to inject particular pieces of source data. So if you have a pattern for a hero element, and you know from your source data what the image URL is supposed to be, what the title is supposed to be. We can use the HTML directly from the pattern file, and do lightweight search replaces within that using either direct PHP string replacements or a tool that we&#8217;ve written, that I shared a link to called rehydrator, which is a very early stage experiment, that we&#8217;ve got out on GitHub.</p>



<p class="wp-block-paragraph">And we can use that to put the content into the structure that it&#8217;s going to need to have for it to be fully, visually correct. So rather than just reducing and throwing away anything that isn&#8217;t a heading or a paragraph, we&#8217;re taking the framework from the theme pattern that&#8217;s been built. And then we&#8217;re writing a migrator that takes data and puts it into that HTML structure, and saves that into the post content. So that when an editor opens up a page, it loads correctly in the editor without block validation errors and it looks right on the front end.</p>



<p class="wp-block-paragraph">[00:13:15] <strong>Nathan Wrigley:</strong> Okay. There&#8217;s a lot of depth in that, isn&#8217;t there? We&#8217;ll come back to that in a moment.</p>



<p class="wp-block-paragraph">I&#8217;m curious about process of how you, persuade clients that you are going to be able to carry this work out successfully. So how does that actually work? You obviously look at their existing content, you have a discussion about what the new design is going to look like, and then do you build out some kind of templates or patterns or what have you, so that you can then pull in a proportion of the content, maybe, I don&#8217;t know, 10 or a hundred or 5,000 or whatever it may be, pieces of content. Check that that&#8217;s all right. Show it to the client. How does that workflow go to build up their confidence that what you are going to do when you finally click the button is actually going to succeed?</p>



<p class="wp-block-paragraph">[00:13:50] <strong>K. Adam White:</strong> The way that we&#8217;ve been approaching that, I think particularly, over the past six months, I should caveat first that this process has changed so much. Because the tools we have available with AI agents have been evolving in leaps and bounds alongside this particular migration process, which started in January.</p>



<p class="wp-block-paragraph">So in this case, we started out by building patterns that we could put content for one test post, from the existing site manually. Bringing the contents over, copying and pasting headings, et cetera. And using that to create the patterns that we could show to the client to say, does this look correct? Does this structure mirror what you&#8217;re expecting? Is this what you expect an author to have available within the post editor?</p>



<p class="wp-block-paragraph">And then you know, which pieces belong in the template, which pieces are managed at the site editor level? We&#8217;ve done a lot of that ahead of starting the actual migration.</p>



<p class="wp-block-paragraph">Now that the migration is in progress, any subsequent pieces we&#8217;re developing in tandem, we&#8217;re saying, okay, we have a press release. That press release, we have audited the incoming data, and we have determined that there are four different layouts for press releases. And this one is used the most and it has these elements. This one is used less, but it has images, et cetera.</p>



<p class="wp-block-paragraph">And we can build the template for that post type, and at the same time write the migrator for identifying the content nodes, and the source data and bringing that information over into the new patterns.</p>



<p class="wp-block-paragraph">So we have the patterns that we can show, okay, if you&#8217;re building something from scratch, this is what that looks like in the editor. But then at the same time, we can run the migrator over, in most cases, all of the relevant type of data and say, and here is a list of pages to validate.</p>



<p class="wp-block-paragraph">So what we&#8217;ve been doing is bringing that to our stakeholder, and allowing them to do spot checks, so that they can look through and validate that there are all of the required elements on the test pages. Things like, &#8220;oh, alright, we don&#8217;t have a mapper yet for video embeds. So videos are missing,&#8221; and that&#8217;s usually going to be an all or nothing thing. We&#8217;ve found very few cases where we end up with one or two errors on a specific post basis that aren&#8217;t related to support for a complete type of output pattern.</p>



<p class="wp-block-paragraph">[00:15:55] <strong>Nathan Wrigley:</strong> Is there a sort of fault tolerance there? So obviously in the case of this particular migration, tens of thousands of posts, I guess there&#8217;s never going to be a moment where you can be a hundred percent confident apart from reading the 10,000 posts that you&#8217;ve done everything correctly. Is there a, we&#8217;ll do 10 to begin with, then we&#8217;ll go up to a hundred, then we&#8217;ll go up to a thousand.</p>



<p class="wp-block-paragraph">What, is the sort of tolerance that you present to the client? I&#8217;m just imagining that just lurking in post 9,999 is just some weird thing that was allowable in the CMS but never got used before or since, and that piece of content got missed. I don&#8217;t know what&#8217;s allowable in that scenario. So is there any level of tolerance for fault?</p>



<p class="wp-block-paragraph">[00:16:32] <strong>K. Adam White:</strong> The major advance that we&#8217;ve made with migrations as a broad structure this year is a much better understanding of those edge cases. And the way that we&#8217;ve done that is by leveraging Claude and various other tools to do cross site audits to make sure that we have a full picture of the source data.</p>



<p class="wp-block-paragraph">So we are able to feed in whatever export files we get from our source site. In this case we&#8217;re working from Sitecore, which is an enterprise CMS, which has two database structure. There&#8217;s actually a database with a content tree, and then another database that contains layout information. And a page is rendered by switching back and forth between those and assembling the final output.</p>



<p class="wp-block-paragraph">We were able to get exports of the relevant content from both of those, from the developer of the current site. And we fed those and a whole bunch of documents from the product owner into a ongoing conversation with Claude. And we&#8217;re able to use that to build some actually node.js scripts that would take the files we&#8217;d gotten from the Sitecore devs, and build a local database in SQLite that each developer on the team was able to run locally. And we can query against that to find those edge cases.</p>



<p class="wp-block-paragraph">So in a combination of writing our own manual queries, or having a chat conversation prompt for finding individual things, and then it will run a number of queries and report back to us. We&#8217;re able to identify very quickly, oh, there&#8217;s only one press release that has images, that&#8217;s interesting. But there are 17 that have a FAQ accordion.</p>



<p class="wp-block-paragraph">So that type of auditing has become trivial, and it&#8217;s mind boggling how much faster that&#8217;s allowed us to move in terms of understanding the data that&#8217;s there, and building out a mapping of how we&#8217;ll migrate through the different types of content.</p>



<p class="wp-block-paragraph">We don&#8217;t tend to start with only 10 pages in a post type because it&#8217;s relatively cheap to run the migrator over a thousand instead of 10. And that gives you a lot more content for both various people on the client team, but then also agentic tools to click through and do a little bit of spot check validation.</p>



<p class="wp-block-paragraph">What we tend to do is to migrate content type by content type, and we&#8217;ll prioritise those based on what we see as the balance between scale and complexity.</p>



<p class="wp-block-paragraph">[00:18:39] <strong>Nathan Wrigley:</strong> Do you leverage Core blocks wherever possible, or do you bring bespoke Human Made blocks where that&#8217;s necessary? Or can you basically bind everything in this particular build to a Core block?</p>



<p class="wp-block-paragraph">[00:18:51] <strong>K. Adam White:</strong> Most of the time we will start with Core blocks and get as far as we can with them. This is a change from how we used to do it. Our early days, we had a lot of rapid iteration in the markup that Core blocks were using. In some cases, there was a lot of evolution in how the controls for them were set up.</p>



<p class="wp-block-paragraph">[00:19:07] <strong>Nathan Wrigley:</strong> It was brutal.</p>



<p class="wp-block-paragraph">[00:19:09] <strong>K. Adam White:</strong> It was brutal. But that pace of change for the main building blocks of a site has slowed down tremendously, and I think it&#8217;s a very stable foundation. So we will be pattern first in our development. We will start by working, doing a lot of in-editor prototyping actually, to build out layouts and patterns for each individual unit of content, each individual sort of component group in the source site. And, it will only be when we run into something like a carousel or a modal that we might reach for a off the shelf, third party option that&#8217;s not in Core, or bring our own solution to the table.</p>



<p class="wp-block-paragraph">[00:19:45] <strong>Nathan Wrigley:</strong> So do you take, when you said pattern there, is a pattern a sub component of a, let&#8217;s say post for want of a better word? Or is it that the pattern is the entire post with bits injected into it? So paragraphs, headings, videos, whatever it may be? Like I said, at the beginning, or are you building up the entire post from various different patterns? Here&#8217;s a video pattern and here&#8217;s a, I don&#8217;t know, a paragraph pattern with a heading? Or a background image or whatever it may be.</p>



<p class="wp-block-paragraph">[00:20:12] <strong>K. Adam White:</strong> Patterns tends to be at number of different levels. We might have individual patterns for a particular treatment of headline for example. But we also will have a pattern for a hero section. We&#8217;ll have a pattern for a hero section plus the bio below that, that we can use to populate a template in the site editor.</p>



<p class="wp-block-paragraph">We build patterns at multiple levels of granularity, and we have a leaf to trunk system where we&#8217;ll make sure that we have renderings, whether they&#8217;re Core blocks with either default styling or one or two block variations, or individual patterns for things where we need to compose one or two blocks together. We&#8217;ll make sure that we have all of those leaf node pieces of content, all of our paragraphs, all of our inline images. And then we&#8217;ll build patterns for those higher level groups, the full width backgrounds with coloration and a particular headline treatment.</p>



<p class="wp-block-paragraph">We build out those patterns at all of those different levels because it&#8217;s nice to have the granularity when we&#8217;re writing our migrators, and patterns can reference each other. So you can have an accordion pattern, which includes two references to an accordion item pattern, and you can have all of those little bits of HTML be discreet PHP files in your WordPress theme. So it makes it very simple to pull up in your editor only the code that you need to edit for a particular unit and know how that&#8217;s going to be scoped.</p>



<p class="wp-block-paragraph">[00:21:26] <strong>Nathan Wrigley:</strong> This is going to sound like such a peculiar question, but it genuinely, from my point of view, this sounds like really interesting and curious work. It sounds, like there&#8217;s a lot to get your teeth into. You&#8217;re pushing the boundaries a little bit, but also you&#8217;ve got the scope of WordPress, which kind of makes it slightly easier.</p>



<p class="wp-block-paragraph">I&#8217;m basically just making the comment that I think I would enjoy doing the work that you are doing. I don&#8217;t know if that, yeah, there really a question there.</p>



<p class="wp-block-paragraph">[00:21:47] <strong>K. Adam White:</strong> Unfortunately, we&#8217;re doing less and less of that work, and Claude&#8217;s doing more and more of it. It&#8217;s been actually very efficient because this is such a core central construct in the WordPress block editor. There&#8217;s a lot of good documentation about it and agentic tools are quite good at helping to build pattern markup.</p>



<p class="wp-block-paragraph">So, what we&#8217;ve been doing is bringing our human eyes onto that, doing all of our spot checks, making sure that things are kept as simple as possible. Because I think we&#8217;re all familiar with how verbose and overly complicated output can be from some tools. But then it is also something that I really wish more people were talking about and doing. Brian Coords earlier today in his talk, mentioned that pattern driven development really he sees as something that more and more of the WordPress community should be trying out. Because there are so many things that we used to build custom blocks for, that just strictly aren&#8217;t necessary anymore. And we can get so far by composing what we get from the lego kit of WordPress out of the box.</p>



<p class="wp-block-paragraph">[00:22:40] <strong>Nathan Wrigley:</strong> Yeah, I feel like if we went back to 2015 and began Gutenberg again, I feel going patterns first would actually be a nicer approach, certainly a more straightforward approach. I know that there&#8217;s, ways to overcome that, but I always drop patterns in, never blocks, and then I&#8217;m always interacting with the blocks within the pattern. But it&#8217;s patterns first for me all the time. Just because I like the fact that I&#8217;m dropping in multiple bits of content that are pre-configured and pre-made and pre, I&#8217;ve fiddled with the CSS and made it just how I like it. And I just click the button once and there it is, and I can just rinse and repeat and it&#8217;s really straightforward.</p>



<p class="wp-block-paragraph">[00:23:12] <strong>K. Adam White:</strong> I would agree, and over the past two to five releases of WordPress, we&#8217;ve also had such powerful additional tools added to the pattern toolkit. For example, Partially Synced Patterns. Was a major topic that I shared in my talk. Being able to have a reusable pattern and then make the content editable on a post by post basis makes it very seamless for a non-technical editor to go in, and not have access out of the box to stylistic controls that would make something drift from the brand&#8217;s guidelines that they&#8217;re trying to follow, but still be able to customise link targets, CTA, text, all of the descriptive and image elements.</p>



<p class="wp-block-paragraph">[00:23:47] <strong>Nathan Wrigley:</strong> You are in the weeds of WordPress, and I&#8217;m in the weeds of WordPress all the time, but I still feel those tools are widely, not misunderstood, that&#8217;s the wrong, just there&#8217;s a void. Nobody even knows they&#8217;re there. There&#8217;s just tonnes of tooling inside the block editor that people simply don&#8217;t know about, because the UI and the UX is still a bit funky. You&#8217;ve got to go to various different places, and it&#8217;s easy to go down the wrong route.</p>



<p class="wp-block-paragraph">Do you know what I mean? There&#8217;s a bunch of tools inside a WordPress that if you only had a few hours with somebody over your shoulder pointing out, &#8220;okay, click on that, look at that menu that does this thing.&#8221; It&#8217;s a shame in a way that&#8217;s the case. But I do feel there&#8217;s a lot of unexplored potential in every WordPress website that presumably you are leveraging. But I guess just because you&#8217;re in the weeds of it.</p>



<p class="wp-block-paragraph">[00:24:30] <strong>K. Adam White:</strong> Wherever possible, we have the privilege of having a lot of history with the CMS. Human Made was founded in 2010 and has always had a strong open source posture. We&#8217;ve contributed to Core, we&#8217;ve put plugins out there in the ecosystem that are used by a number of other agencies. We&#8217;ve found the best of what our frenemy competitors use, and been able to adopt those into our own processes.</p>



<p class="wp-block-paragraph">And the benefits of understanding all of the different types of block that you can use tremendously outweigh any time sink that it takes to learn them. I hope that, from my talk, people will now know that in 7.0, we added PHP only blocks, where you can have the attributes auto registered so that you get, even as a non JavaScript developer, a interface in the editor that someone can open up and go in and change values in the sidebar.</p>



<p class="wp-block-paragraph">I hope that more people learn about Partially Synced Patterns. I hope more people learn about all of the different types of block that we have available, and find ways to integrate those into their own toolkits. Because playing with the grain of WordPress and using the Block Editor for all it&#8217;s worth, are how we untap the most value for our clients.</p>



<p class="wp-block-paragraph">[00:25:34] <strong>Nathan Wrigley:</strong> Yeah, there is certainly an awful lot of power, and like I said, I just think some of it gets missed.</p>



<p class="wp-block-paragraph">How much after you&#8217;ve done the migration, how much time do you have to spend with the clients? I have this impression that the Gutenberg editor is pretty straightforward, muscle memory for me essentially. Hours of playing in it. I know where all the bits and pieces are.</p>



<p class="wp-block-paragraph">But I would also recognise that if I was to show it to somebody who&#8217;d never played with WordPress and was coming from, in this case Sitecore, how overwhelming is it? And do you take steps to make it less overwhelming by minimising what&#8217;s available in the interface, or just disabling options? What do you do in that regard?</p>



<p class="wp-block-paragraph">[00:26:08] <strong>K. Adam White:</strong> No matter how much flexibility our clients want, it&#8217;s usually valuable to disable some options. I can&#8217;t remember a site we&#8217;ve shipped recently for any large website where we left the custom colour picker in, for example. You want to do a better job of limiting what people can use, so that we have confidence that the output, no matter how design savvy or not someone is, is going to be consistent with the rest of the site.</p>



<p class="wp-block-paragraph">My colleague, Joeleen Kennedy, gave a talk a couple years ago at the first  WordCamp US Showcase Day back in 2024, about work we had done customising the editor for that type of simplicity. And in particular things that we can do around colour palette selection. Ways that we can hide the styling controls for certain blocks through having them embedded in a pattern.</p>



<p class="wp-block-paragraph">It&#8217;s interesting to see that in WordPress recently, if you are editing content that has been marked as having come from a pattern in a post, you can edit all of the text, you can edit all of the images and link targets, but you actually have to hit edit pattern in the sidebar in some cases, depending on how the post is set up, to get into the details within the post that allow all of those other controls to be visible.</p>



<p class="wp-block-paragraph">That divide took a tiny bit of adjustment for people on our client teams, but the separation has helped them stay focused on the content, and worry less about the overwhelming, combinatorial set of styling possibilities that their blocks have.</p>



<p class="wp-block-paragraph">[00:27:29] <strong>Nathan Wrigley:</strong> Do you think that the necessary tools are already built into WordPress to do the kind of work that you are doing? Or is there some missing piece that would make it easier for somebody who doesn&#8217;t have the deep pockets that presumably Human Made would require, to do that kind of work. Is the default tooling usually okay to migrate things or have you had to build loads of bespoke tooling?</p>



<p class="wp-block-paragraph">So in terms of if I was to approach a WordPress website and try to migrate from Sitecore over to WordPress, is this something that you absolutely need a team to do, or would you be able to get some simulation of this with Core WordPress?</p>



<p class="wp-block-paragraph">[00:28:04] <strong>K. Adam White:</strong> If you had access to the exports of data from a Sitecore website, and you had a core vanilla WordPress install. And you had a LLM tool of some sort, I think that you could do a lot to get close to what you want. The LLM piece, I think enables this to be done by more people without having to be completely familiar with all of the internal nuances of WordPress. You need to direct it to the architectural pattern that you want, but we have found that it speaks Gutenberg pretty well.</p>



<p class="wp-block-paragraph">[00:28:32] <strong>Nathan Wrigley:</strong> What was the name of the tool that you said you&#8217;d custom and built?</p>



<p class="wp-block-paragraph">[00:28:34] <strong>K. Adam White:</strong> We had built a plugin called rehydrator.</p>



<p class="wp-block-paragraph">[00:28:36] <strong>Nathan Wrigley:</strong> Okay, rehydrator, yeah.</p>



<p class="wp-block-paragraph">[00:28:37] <strong>K. Adam White:</strong> rehydrator is the tool that we use to take a pattern in the theme and then use that pattern as the template when we&#8217;re bringing content over to make sure that we keep all of the styling theme side, and that our migration script doesn&#8217;t duplicate the markup specifically.</p>



<p class="wp-block-paragraph">[00:28:51] <strong>Nathan Wrigley:</strong> What&#8217;s Human Made&#8217;s approach to the WordPress project in that regard? You said it was a plugin. Does that mean it&#8217;s a wordpress.org repository plugin, or is it one that you have on your own, I don&#8217;t know, GitHub repository or whatever it may be.</p>



<p class="wp-block-paragraph">[00:29:01] <strong>K. Adam White:</strong> We have some things in the .org repository. In this case, that particular plugin is only on GitHub. A number of ones that we build are only on GitHub, because we&#8217;re building them for a very transient in time period of a site.</p>



<p class="wp-block-paragraph">You don&#8217;t need a migration tool to be part of your site long term, it&#8217;s not something you&#8217;re going to be leaving active, and updating month over month when there is a site running. It&#8217;s something that you bring in for the purpose of populating the data. And then you can remove that.</p>



<p class="wp-block-paragraph">And in that regard, for this particular one, at the moment it&#8217;s partly because it&#8217;s quite young, and it&#8217;s also because we don&#8217;t see it as being general purpose. So that plugin specifically is on GitHub and publicly available through Composer, but not on the plugin directory.</p>



<p class="wp-block-paragraph">In other situations, we&#8217;ve gone the opposite direction, and anything that we see as being a ongoing value to a site as it&#8217;s running, we do try to move those over as we can.</p>



<p class="wp-block-paragraph">[00:29:52] <strong>Nathan Wrigley:</strong> Given that you are on the sort of engineering side of Human Made, I don&#8217;t know if this question will land, but we seem to be in this interesting period where there&#8217;s a lot of chatter, AI kind of fits into the equation a little bit, but there&#8217;s a lot of chatter about the, market share of WordPress and whether or not WordPress as a tool will continue with the same numbers and clout and market share and all of those kind of things.</p>



<p class="wp-block-paragraph">Do you notice at the enterprise level that there&#8217;s been any kind of change in a southerly direction? Maybe there&#8217;s been a direct change in a northerly direction. What I&#8217;m trying to say is, for the enterprise, does WordPress still maintain that kind of pride place, top of the tree, or are you struggling to find new clients?</p>



<p class="wp-block-paragraph">[00:30:28] <strong>K. Adam White:</strong> We&#8217;re not struggling to find new clients. We&#8217;re lucky that we&#8217;re doing quite well on marketing, and we also have had a very powerful year in terms of building relationships with new enterprises, and finding ways to take the technology that we believe in and solve their problems with it.</p>



<p class="wp-block-paragraph">But I would argue that WordPress has never been the top of the enterprise space. And this actually goes back to your question about what is there that might be missing inside WordPress. The biggest thing that I think someone gets from a more, I&#8217;m going to use the term loosely, traditional enterprise CMS, is control.</p>



<p class="wp-block-paragraph">And WordPress has a security model where the ability to edit and publish a piece of content is usually at the post level. There&#8217;s ways to add specific permission checks for metadata. There&#8217;s ways that you can restrict what&#8217;s accessible and editable with custom interfaces and custom API endpoints. But we tend to have things fall down to the capability checks for user can edit post 1, 2, 3. Yes. No.</p>



<p class="wp-block-paragraph">And that means that if you have a user profile where your organisation depends on someone being able to come in and touch only the headlines and the SEO metadata, we don&#8217;t really have a model for that right now in WordPress.</p>



<p class="wp-block-paragraph">Whereas something like Sitecore, each individual, almost at the level of every string on the site, whether it&#8217;s a set of paragraphs or the label of a button, ends up as a individual node in the content tree. And those can be granted or denied to certain users on a much more granular level. So that to me is a bridge that I still am excited to see what we can do within WordPress to maybe build better interfaces, or better primitives in the editor.</p>



<p class="wp-block-paragraph">Block locking helps a little bit, but it is an API that&#8217;s quite difficult for some teams to wrap their heads around. And it also doesn&#8217;t really change the fact that if you can edit the post, and you were able to get the code editor up, then if you&#8217;re able to save it, you&#8217;re able to save it and doesn&#8217;t really go block by block. You&#8217;d have to write custom validation or permissions logic in order to be able to reject and update based on the user if they&#8217;re editing a block that is next to the one that they were supposed to.</p>



<p class="wp-block-paragraph">[00:32:32] <strong>Nathan Wrigley:</strong> So do you have to present to the clients? It&#8217;ll be fine. This is what WordPress has. Don&#8217;t worry too much about it. If you&#8217;ve got this permission, yep, sure. You might be able to overlap and think people could delete things or modify things that perhaps they wouldn&#8217;t have to. That&#8217;s an educational piece on your side. Go and teach everybody not to mess around with things that they shouldn&#8217;t be messing around with.</p>



<p class="wp-block-paragraph">But you would wish that in WordPress you could assign, say, as you described, this H1, this person can amend it, and this person can access the colour palette for the background image over here, but they can&#8217;t access the text. That kind of really granular permission. Whereas block locking just, it seems a bit more of a blunt instrument if you know what I mean. It&#8217;s binary. It&#8217;s locked or it&#8217;s not. You&#8217;d like to unlock the capabilities within each block so that certain users can do certain things within the same block.</p>



<p class="wp-block-paragraph">[00:33:15] <strong>K. Adam White:</strong> Within blocks, we tend to rely on security through obscurity. We can hide or obfuscate controls behind block locking with content only. We can hide them behind patterns. But if someone&#8217;s coming to WordPress, we do make sure that they understand upfront what the nuance of control will be. And we will work with them usually to make things more editable.</p>



<p class="wp-block-paragraph">Again, I will mention that most of the projects that we get that come from one of these more control-oriented CMSs into WordPress, what they&#8217;re seeking is actually more flexibility, not less. So they&#8217;re making a decision that they are willing to exchange the stringent control that they get in their existing tool for a process-based change. Maybe they add a review step, or add some sort of workflow plugin, so that we can validate that things look good and have someone sign off on it before it gets published. They would prefer to go that route than to sacrifice the ability for the editors to have the full control, and full pallet of options available to them.</p>



<p class="wp-block-paragraph">[00:34:13] <strong>Nathan Wrigley:</strong> Right, so that&#8217;s a much more loose approach. Everybody can maybe do more than they ought to do. If we have some editorial guideline where that can&#8217;t finally hit the public domain because the publish button is unavailable to you, that&#8217;s, okay. We&#8217;ll accept that kinda halfway house, if you like. That&#8217;s interesting.</p>



<p class="wp-block-paragraph">[00:34:30] <strong>K. Adam White:</strong> Each client&#8217;s needs are going to be slightly different. We do layer in publication checklists. We have tools to be able to say, this has to be tagged with the primary category before it goes live. We have tools to say, this still has lorum ipsum in it. You can add those in and build workflows, but I tend to like to help clients build processes to support those, rather than trying to take a draconian approach and lock everything down. Because then your work is going to be constantly chasing fine-grained permissions controls when you could be working to use that time making sure that all of the editors know what they can do.</p>



<p class="wp-block-paragraph">[00:35:04] <strong>Nathan Wrigley:</strong> I just want to drill into this a bit more. I know this isn&#8217;t where we were supposed to go, but I find it really interesting. Would you like those things to ship in Core? obviously they suit you down to the ground, all of those granular permissions, but do you think that belongs in Core?</p>



<p class="wp-block-paragraph">[00:35:17] <strong>K. Adam White:</strong> I think that we need more workflow in Core.</p>



<p class="wp-block-paragraph">[00:35:20] <strong>Nathan Wrigley:</strong> Okay.</p>



<p class="wp-block-paragraph">[00:35:20] <strong>K. Adam White:</strong> I know that there&#8217;s a number of different agencies and hosts which each have developed our own workflows solutions. I&#8217;ve worked across a number of them on projects that I&#8217;ve helped to support.</p>



<p class="wp-block-paragraph">But the notion that if you have something published and you make an edit out of the box, WordPress will automatically put live any further changes that you make to a published post when you hit save. That is probably the single thing that we most frequently have to build some type of plugin into a site to handle.</p>



<p class="wp-block-paragraph">Because we need to be able to give people an editorial review step. So that is something that I think we have a number of good tools, but I would love to see a more opinionated default in Core that we can use as a foundation for more complicated post editorial workflow. I think that&#8217;s the thing that we most frequently run into. That, and also I guess internationalisation are probably the two things that hopefully will come to the surface of the WordPress roadmap over time.</p>



<p class="wp-block-paragraph">[00:36:13] <strong>Nathan Wrigley:</strong> Yeah, I&#8217;d really not thought about that. Given Human Made&#8217;s sort of credentials and what have you. Do you have a lot of clout? Do you just punch above your weight in conversations about what makes it into Core? Do you get involved in those discussions? I&#8217;ve literally no idea how that would happen. Do you communicate to people when a release is coming around. Do you have a voice? Do you make yourself available? What is Human Made&#8217;s position in terms of getting things pushed into Core?</p>



<p class="wp-block-paragraph">[00:36:37] <strong>K. Adam White:</strong> We participate in the project. I personally have been less involved in Core over the past several years than I would have hoped. I&#8217;ve been very much enjoying the detailed, quite close to the ground work that I&#8217;m doing on our agency projects. But unfortunately, I have taken a bit of a step back on the open source project.</p>



<p class="wp-block-paragraph">Some of my colleagues are in a slightly different boat. My colleague, John Blackbourn, our Director of Security for our own hosting product is also the head of the Security Team for WordPress? And has been helping us get the core patches out for the recent set of security releases.</p>



<p class="wp-block-paragraph">We obviously will advocate in calls for feedback within the Gutenberg project when we feel that there&#8217;s a particular direction that we see from our projects. We are able to provide feedback on the UI, and the capabilities of new blocks that are being proposed. But that&#8217;s all done through the normal Gutenberg GitHub issue, and WordPress</p>



<p class="wp-block-paragraph">[00:37:28] <strong>Nathan Wrigley:</strong> So I think we should probably knock it on the head there. We&#8217;ve reached our allocated time. I&#8217;ll just point out that these days, it used to be the case that if I was at a WordCamp, you&#8217;d really have to wait about six months before the video for the presentation was available. I&#8217;m pretty sure it&#8217;ll be done already, in all honesty. 24 hours seems to be the time there. So if you were to go to WP Tavern, I will make sure that the link to the video, of K. Adam is there. If not, you can probably go to Google and search Migrating to Blocks, and in parenthesis, with Artisanal Care at Industrial Scale, and you&#8217;ll be able to see what it is that K. Adam was talking about.</p>



<p class="wp-block-paragraph">But really, thank you so much for chatting to me today about all of that.</p>



<p class="wp-block-paragraph">[00:38:06] <strong>K. Adam White:</strong> Thank you very much. And I can confirm that the video is already live on YouTube.</p>
</div></details>



<p class="wp-block-paragraph">On the podcast today we have <a href="https://www.linkedin.com/in/kadamwhite/">K. Adam White</a>, or K. Adam for short.</p>



<p class="wp-block-paragraph">K. Adam is the principal engineer at Human Made, an enterprise WordPress consultancy. He’s been involved with WordPress almost 20 years, attended his first WordCamp in Boston back in 2011, and has contributed to WordPress Core and the broader open source ecosystem. Human Made is known for delivering complex projects, think high stakes, no room for mistakes, from global brands moving to WordPress.</p>



<p class="wp-block-paragraph">This time around, K. Adam delivered a presentation at WordCamp US focused on a crucial topic for anyone modernising their site, migrating to blocks. Human Made has been all-in on the block editor since the Gutenberg plugin days, and the team now specialises in large-scale migrations from other content management systems like Sitecore, as well as from other WordPress page builders.</p>



<p class="wp-block-paragraph">Our conversation focused on the technical and editorial challenges of moving tens or hundreds of thousands of posts into the world of blocks and patterns. We talked about the need to combine &#8220;artisanal care&#8221;, attention to detail in design, layout, and brand, with &#8220;industrial scale&#8221;, the ability to automate, audit, and validate mass migrations without losing visual fidelity.</p>



<p class="wp-block-paragraph">We also discussed the use of patterns as a foundation for development, integrating custom and Core blocks, and leveraging new tools (including AI-powered agents and open source plugins like Human Made’s own rehydrator) to streamline migration workflows. We also touched upon how clients are onboarded, the process of auditing legacy content, strategies for training editorial teams on the block editor, and there’s a frank reflection on gaps in WordPress, like granular content permissions.</p>



<p class="wp-block-paragraph">If you’re contemplating a move to the block editor, wrestling with a massive content migration, or curious about what happens when enterprise complexity meets the flexibility of WordPress, this episode is for you.</p>



<h2 class="wp-block-heading">Useful links</h2>



<p class="wp-block-paragraph"><a href="https://humanmade.com">Human Made</a></p>



<p class="wp-block-paragraph"><a href="https://us.wordcamp.org/2026/session/migrating-to-blocks-with-artisanal-care-at-industrial-scale/">Migrating to Blocks (With Artisanal Care, at Industrial Scale)</a> &#8211; K. Adam&#8217;s presentation at WordCamp US 2026</p>



<p class="wp-block-paragraph">Human Made&#8217;s <a href="https://github.com/humanmade/rehydrator">rehydrator plugin on GitHub</a></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Wed, 23 Sep 2026 12:53:53 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:14:"Nathan Wrigley";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:41;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:43:"WordPress.org blog: WordPress 7.1.2 Release";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"https://wordpress.org/news/?p=21731";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:59:"https://wordpress.org/news/2026/09/wordpress-7-1-2-release/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:3425:"<p class="wp-block-paragraph">This security release features a fix for a critical severity security vulnerability.</p>



<p class="wp-block-paragraph"><strong>Because this is a security release, it is recommended that you update your sites immediately.</strong></p>



<p class="wp-block-paragraph">You can <a href="https://wordpress.org/download/">download WordPress 7.1.2 from WordPress.org</a>, or visit your WordPress Dashboard, click “Updates”, and then click “Update Now”. If you have sites that support automatic background updates, the update process will begin automatically.</p>



<h2 class="wp-block-heading">Security update included in this release</h2>



<p class="wp-block-paragraph">The security team would like to thank <a href="https://ressl.ch/">Robert Ressl</a> for responsibly disclosing that an unauthenticated attacker can, under certain conditions, make page template resolution include a chosen readable local PHP file outside the active theme directories. If relevant pre-conditions for both the server environment and the active theme are met, this can lead to remote code execution (RCE).</p>



<h2 class="wp-block-heading">Thank you to these WordPress contributors</h2>



<p class="wp-block-paragraph">This release was led by <a href="https://w.org/@johnbillion">John Blackbourn</a>. WordPress 7.1.2 would not have been possible without the contributions of the following people:</p>



<p class="wp-block-paragraph"><a href="https://w.org/@jorbin">Aaron Jorbin</a>, <a href="https://w.org/@wildworks">Aki Hamano</a>, <a href="https://w.org/@xknown">Alex Concha</a>, <a href="https://w.org/@ehti">Ehtisham Siddiqui</a>, <a href="https://w.org/@fiocavallari">fiocavallari</a>, <a href="https://w.org/@audrasjb">Jb Audras</a>, <a href="https://w.org/@jeffpaul">Jeffrey Paul</a>, <a href="https://w.org/@jeremyfelt">Jeremy Felt</a>, <a href="https://w.org/@joemcgill">Joe McGill</a>, <a href="https://w.org/@johnbillion">John Blackbourn</a>, <a href="https://w.org/@jonsurrell">Jon Surrell</a>, <a href="https://w.org/@lancewillett">Lance Willett</a>, <a href="https://w.org/@sirlouen">Manuel Camargo</a>, <a href="https://w.org/@marcs0h">marcs0h</a>, <a href="https://w.org/@martinkrcho">martin.krcho</a>, <a href="https://w.org/@mukesh27">Mukesh Panchal</a>, <a href="https://w.org/@oglekler">Olga Gleckler</a>, <a href="https://w.org/@swissspidy">Pascal Birchler</a>, <a href="https://w.org/@peterwilsoncc">Peter Wilson</a>, <a href="https://w.org/@rajinsharwar">Rajin Sharwar</a>, <a href="https://w.org/@ressl">Ressl</a>, <a href="https://w.org/@rfaile313">Rudy Faile</a>, <a href="https://w.org/@sergeybiryukov">Sergey Biryukov</a>, <a href="https://w.org/@shailu25">Shail Mehta</a>, <a href="https://w.org/@pypwalters">Stephanie Walters</a>, and <a href="https://w.org/@vortfu">vortfu</a>.</p>



<h2 class="wp-block-heading">CVE and GHSA references</h2>



<p class="wp-block-paragraph">Further details can be found in the advisory: <a href="https://github.com/WordPress/wordpress-develop/security/advisories/GHSA-7hp8-65ch-5whp">CVE-2026-87902 / GHSA-7hp8-65ch-5whp</a>.</p>



<h2 class="wp-block-heading">Backports</h2>



<p class="wp-block-paragraph">As a courtesy, the security fix was backported to all branches eligible to receive security fixes (currently through 4.7). As a reminder, <strong>only the most recent version of WordPress is actively supported</strong>.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 22 Sep 2026 14:01:20 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:15:"John Blackbourn";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:42;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:107:"Open Channels FM: Balancing Tradition and Innovation in Genealogy During the Era of Artificial Intelligence";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2562212";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:114:"https://openchannels.fm/balancing-tradition-and-innovation-in-genealogy-during-the-era-of-artificial-intelligence/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:111:"I makes genealogy faster and more accurate while Charleen Mullenweg explains the ongoing need for human review.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Tue, 22 Sep 2026 12:02:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"Bob Dunn";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:43;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:98:"Open Channels FM: Invisible Unicode Attacks, CrowdSec Source Leak, and the AI Coding Boom Explored";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2562271";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:103:"https://openchannels.fm/invisible-unicode-attacks-crowdsec-source-leak-and-the-ai-coding-boom-explored/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:134:"Invisible characters challenge spam filters, CrowdSec deals with a code leak, and AI is shifting what matters in software development.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 21 Sep 2026 15:30:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"Bob Dunn";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:44;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:31:"bbPress: bbPress 2.6.18 is out!";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:29:"https://bbpress.org/?p=249876";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:55:"https://bbpress.org/blog/2026/09/bbpress-2-6-18-is-out/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:1178:"<p class="wp-block-paragraph">bbPress 2.6.18 is a maintenance release focused on forum imports and first-login password upgrades.</p>



<p class="wp-block-paragraph">Imported users can now upgrade their passwords on first login for more legacy forum formats, including cases where the original forum database is no longer available. This release also corrects PHPWind topic statuses, reply counts, and forum dates during import, and restores Super Moderator edit links on front-end bbPress user screens.</p>



<p class="wp-block-paragraph">bbPress 2.6.18 requires PHP 7.2 or newer and WordPress 6.0 or newer. Sites running an older PHP version should update PHP before upgrading bbPress. <a href="https://codex.bbpress.org/releases/bbpress-2-6-18/">Read the 2.6.18 upgrade notes</a> for importer compatibility details.</p>



<p class="wp-block-paragraph">These changes are also in the 2.7 development branch. The Plugin Directory’s development trunk remains at 2.7.0-alpha-3.</p>



<p class="wp-block-paragraph"><a href="https://downloads.wordpress.org/plugin/bbpress.2.6.18.zip">Download bbPress 2.6.18</a> from WordPress.org, or update from your WordPress dashboard.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 21 Sep 2026 14:53:41 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:17:"John James Jacoby";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:45;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:78:"WordPress.org blog: WordPress Takes Its Turn Leading the Open Website Alliance";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:35:"https://wordpress.org/news/?p=21709";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:49:"https://wordpress.org/news/2026/09/owa-president/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2391:"<p class="wp-block-paragraph">I’m happy to announce that I am now serving as president of the <a href="https://openwebsitealliance.org/">Open Website Alliance</a> (OWA), representing the WordPress Foundation. The Alliance brings together the community organizations behind <a href="https://www.drupal.org/">Drupal</a>, <a href="https://www.joomla.org/">Joomla!</a>, <a href="https://typo3.org/">TYPO3</a>, and WordPress to advocate for open source and share practices that benefit their projects. I represent the WordPress Foundation in this role, which rotates among the Alliance’s members.</p>



<figure class="wp-block-image size-large"><img alt="" class="wp-image-21712" height="576" src="https://i0.wp.com/wordpress.org/news/files/2026/09/image-3.png?resize=1024%2C576&#038;ssl=1" width="1024" /></figure>



<p class="wp-block-paragraph">WordPress <a href="https://x.com/WordPress/status/1755516866485707064">announced its participation in the Alliance in 2024</a>, building on our work with Drupal, Joomla!, and TYPO3 to <a href="https://wordpress.org/news/2023/08/concerns-over-the-european-unions-cyber-resilience-act-cra/">respond to the European Union’s Cyber Resilience Act</a>. While many open source projects focus on underlying digital infrastructure, our content management systems power the websites where businesses reach customers and sell products and services. We asked policymakers to account for that economic role when setting security requirements, while respecting how communities of developers, translators, educators, and other contributors build and maintain the software. We share a belief that everyone should have the freedom to use, change, and share the tools they rely on.</p>



<p class="wp-block-paragraph">This commitment to openness builds on efforts such WordPress’s recent signing of the <a href="https://wordpress.org/news/2026/08/open-weight/">Open Weights and American AI Leadership letter</a>. Our mission to democratize publishing means giving anyone a voice and welcoming everyone to contribute. Working with other communities puts those values into practice beyond WordPress, supporting the freedoms that make participation possible. I invite you to read the <a href="https://openwebsitealliance.org/charter.html">Open Website Alliance charter</a> to learn more about the commitments its members share and how the Alliance works.</p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 21 Sep 2026 14:28:41 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:12:"Mary Hubbard";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:46;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:85:"OpenStation Blog: Drag, Drop, Preview: Writing a Post in OpenStation, Start to Finish";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"https://openstation.blog/?p=1220";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:93:"https://openstation.blog/2026/09/21/drag-drop-preview-an-ordinary-day-writing-in-openstation/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:2340:"<p class="wp-block-paragraph">I started writing a post (this post!).</p>



<p class="wp-block-paragraph">Then, as usually happens, I needed a picture, so I dragged one straight from my desktop into OpenStation. No downloading, no extra tabs needed, no extra spaces in the editor, no more &#8220;in which tab was the image!?&#8221;&#8230; I just dragged it from my desktop&#8230;</p>



<figure class="wp-block-image alignfull"><img alt="Happy" src="https://i0.wp.com/live.staticflickr.com/8449/8006853151_5881bfe507_b.jpg?ssl=1" /></figure>



<p class="wp-block-paragraph">Done!</p>



<p class="wp-block-paragraph">And then I thought the post was already descriptive enough to tell how much we enjoy creating content in OpenStation&#8230; But I missed the preview. I wanted to see what the post would look like and edit it in real time. And it happened, I just had to click on the eye icon in the title bar of this editor.</p>



<p class="wp-block-paragraph">This is probably my favourite kind of productivity, the boring stuff becoming pleasantly simple&#8230;</p>



<p class="wp-block-paragraph">And yes, this whole post was written while recording the video <img alt="🙂" class="wp-smiley" src="https://s.w.org/images/core/emoji/17.0.2/72x72/1f642.png" style="height: 1em;" /></p>



		<figure class="wp-block-jetpack-videopress jetpack-videopress-player">
			<div class="jetpack-videopress-player__wrapper"> </div>
			
			
		</figure>
		


<p class="wp-block-paragraph">But I thought that a quick sanity review from one of my bots would make the post nicer for SEO. So I just saved the draft, and gave it to my agent <img alt="😉" class="wp-smiley" src="https://s.w.org/images/core/emoji/17.0.2/72x72/1f609.png" style="height: 1em;" /></p>



<p class="wp-block-paragraph">And the best part, is that <strong>EVERYTHING</strong> that my Agent did, is traceable.</p>



<figure class="wp-block-image size-large"><img alt="Dashboard view for SEO Medic user profile in OpenStation, showing user information, total content, comments, updates, and recent activity." class="wp-image-1246" height="572" src="https://i0.wp.com/openstation.blog/wp-content/uploads/2026/09/image-12.png?resize=1024%2C572&#038;ssl=1" width="1024" /></figure>



<p class="has-text-align-center wp-block-paragraph"><strong>Switch to OpenStation</strong></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 21 Sep 2026 13:39:51 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Daniel López";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:47;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:58:"Open Channels FM: AI for the Rest of Us, Beyond the Bubble";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2562231";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:64:"https://openchannels.fm/ai-for-the-rest-of-us-beyond-the-bubble/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:74:"Bob Dunn talks about breaking out of AI echo chambers to gain new insights";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Mon, 21 Sep 2026 09:35:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:8:"Bob Dunn";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:48;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:47:"OpenStation Blog: A better way to use WordPress";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:32:"https://openstation.blog/?p=1160";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:66:"https://openstation.blog/2026/09/18/a-better-way-to-use-wordpress/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:5884:"<p class="wp-block-paragraph">I have been using WordPress for a long time, and I still love it. But <code>wp-admin</code> has basically worked in the same way for years.</p>



<p class="wp-block-paragraph"><strong>OpenStation</strong> is our attempt to change that.</p>



<p class="wp-block-paragraph">It&#8217;s a simple idea: instead of moving from one admin page to another, you have a desktop where you can open different parts of WordPress at the same time.</p>



<figure class="wp-block-image size-large"><img alt="A screenshot of the OpenStation interface displaying a welcome message and a list of recent posts on the left, with a detailed view of the 'A better way to use WordPress' post on the right." class="wp-image-1162" height="493" src="https://i0.wp.com/openstation.blog/wp-content/uploads/2026/09/image-7.png?resize=1024%2C493&#038;ssl=1" width="1024" /></figure>



<h2 class="wp-block-heading">Your WordPress. Your workspace.</h2>



<p class="wp-block-paragraph">You can open your posts, pages, media, plugins, WooCommerce or any OpenStation app in different windows.</p>



<p class="wp-block-paragraph">You can move them around, minimize them or put two things next to each other.</p>



<p class="wp-block-paragraph">It may sound like a small difference, but once you start using WordPress this way, it changes a lot.</p>



<h2 class="wp-block-heading">Real-time previews</h2>



<p class="wp-block-paragraph">You can also see your changes while you are working on them.</p>



<p class="wp-block-paragraph">No need to constantly jump between wp-admin and the frontend just to check how something looks.</p>



<figure class="wp-block-image"><img alt="Screenshot of an OpenStation interface showcasing a blog post titled 'A better way to use WordPress' with a dark theme and multiple sections discussing features and mobile compatibility." class="wp-image-1164" height="497" src="https://i0.wp.com/openstation.blog/wp-content/uploads/2026/09/image-8.png?resize=1024%2C497&#038;ssl=1" width="1024" /></figure>



<h2 class="wp-block-heading">Apps inside WordPress</h2>



<p class="wp-block-paragraph">This is one of my favorite parts.</p>



<p class="wp-block-paragraph">We are building apps like AllTerrain Forms, Photo Editor (And more!) specifically for OpenStation.</p>



<p class="wp-block-paragraph">They are still WordPress plugins, but they feel much more like normal desktop apps.</p>



<figure class="wp-block-image size-large"><img alt="A black Nike Air Force 1 sneaker displayed on a table, featuring a blue swoosh and 'OpenStation' branding." class="wp-image-1168" height="673" src="https://i0.wp.com/openstation.blog/wp-content/uploads/2026/09/image-9.png?resize=1024%2C673&#038;ssl=1" width="1024" /></figure>



<h2 class="wp-block-heading">WordPress on your phone</h2>



<p class="wp-block-paragraph">We also wanted OpenStation to work properly on mobile.</p>



<p class="wp-block-paragraph">You can install it as a PWA and use WordPress from your phone almost like any other app.</p>



<figure class="wp-block-image aligncenter size-full"><img alt="A digital interface displaying a grid of application icons with sections for apps and system tools, including options for dashboard, posts, media, and settings." class="wp-image-1170" height="850" src="https://i0.wp.com/openstation.blog/wp-content/uploads/2026/09/image-10.png?resize=493%2C850&#038;ssl=1" width="493" /></figure>



<h2 class="wp-block-heading">Performance Is Fast. Really fast.</h2>



<p class="wp-block-paragraph">OpenStation is not only about changing how WordPress looks.</p>



<p class="wp-block-paragraph">We have put a lot of work into making it fast. In many cases, opening and moving between WordPress screens is faster than using them directly from wp-admin.</p>



<p class="wp-block-paragraph">We are also working on caching and preloading parts of WordPress before you need them.</p>



<p class="wp-block-paragraph">The goal is very simple: you click something and it opens FAST.</p>



<figure class="wp-block-embed is-type-video is-provider-youtube wp-block-embed-youtube wp-embed-aspect-9-16 wp-has-aspect-ratio"><div class="wp-block-embed__wrapper">

</div></figure>



<h2 class="wp-block-heading">And it is still WordPress</h2>



<p class="wp-block-paragraph">This is important.</p>



<p class="wp-block-paragraph">We are not trying to replace WordPress or build another platform on top of it.</p>



<p class="wp-block-paragraph">Your plugins are still your plugins. WooCommerce is still WooCommerce. Your content stays in WordPress.</p>



<p class="wp-block-paragraph">OpenStation just gives you a different way to use all of it.</p>



<p class="wp-block-paragraph">And, of course, it is open source.</p>



<h2 class="wp-block-heading">Thank you</h2>



<p class="wp-block-paragraph">And finally, a big thank you to everyone in the WordPress community who has tried OpenStation, shared feedback, reported bugs or simply told others about it.</p>



<figure class="wp-block-image size-large"><img alt="Grid of contributors to OpenStation showcasing their profile pictures and the number of merged pull requests (PRs) each has contributed." class="wp-image-1190" height="578" src="https://i0.wp.com/openstation.blog/wp-content/uploads/2026/09/image-11.png?resize=1024%2C578&#038;ssl=1" width="1024" /></figure>



<p class="wp-block-paragraph">And especially to all the contributors who are helping us build it. OpenStation would not be what it is today without you.</p>



<p class="wp-block-paragraph">There is still a lot we want to do, and seeing people contributing, experimenting and building things with OpenStation is probably the best part of the whole project.</p>



<p class="wp-block-paragraph">Thank you <img alt="❤" class="wp-smiley" src="https://s.w.org/images/core/emoji/17.0.2/72x72/2764.png" style="height: 1em;" /></p>";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 18 Sep 2026 15:21:06 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:13:"Daniel López";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}i:49;a:6:{s:4:"data";s:21:"
	
	
	
	
	
	
	
	
	
	
";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";s:5:"child";a:2:{s:0:"";a:5:{s:5:"title";a:1:{i:0;a:5:{s:4:"data";s:39:"Open Channels FM: OCN Week in Review #4";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"guid";a:1:{i:0;a:5:{s:4:"data";s:34:"https://openchannels.fm/?p=2562022";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:4:"link";a:1:{i:0;a:5:{s:4:"data";s:45:"https://openchannels.fm/ocn-week-in-review-4/";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:11:"description";a:1:{i:0;a:5:{s:4:"data";s:428:"This week Robert Jacobi shared about  the evolving landscape of open source and tech. Highlights include AI’s growing role in security, WordPress and Apache fortifying their processes, LibreOffice redefining productivity with privacy, LoopConf rethinking event funding, and Switzerland’s bold move toward digital sovereignty. Explore how accountability, control, and sustainability are shaping the future of open technology.";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}s:7:"pubDate";a:1:{i:0;a:5:{s:4:"data";s:31:"Fri, 18 Sep 2026 13:45:00 +0000";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}s:32:"http://purl.org/dc/elements/1.1/";a:1:{s:7:"creator";a:1:{i:0;a:5:{s:4:"data";s:16:"Open Channels FM";s:7:"attribs";a:0:{}s:8:"xml_base";s:0:"";s:17:"xml_base_explicit";b:0;s:8:"xml_lang";s:0:"";}}}}}}}}}}}}}}}}s:4:"type";i:128;s:7:"headers";a:10:{s:6:"server";s:5:"nginx";s:4:"date";s:29:"Wed, 14 Oct 2026 03:23:49 GMT";s:12:"content-type";s:8:"text/xml";s:13:"last-modified";s:29:"Wed, 14 Oct 2026 03:00:33 GMT";s:4:"vary";s:15:"Accept-Encoding";s:15:"x-frame-options";s:10:"SAMEORIGIN";s:16:"content-encoding";s:4:"gzip";s:7:"alt-svc";s:5:"clear";s:13:"x-remembering";s:58:"Eric Binnion <https://friendsofericbinnion.wordpress.com/>";s:4:"x-nc";s:9:"HIT dca 2";}s:5:"build";i:1760615136;s:21:"cache_expiration_time";i:1791951860;s:23:"__cache_expiration_time";i:1791951860;}