require_relative '../script_init'

main_title 'Populate Subscription Discount'

log = Telemetry::MongoidLog
log.clear!

Benchmark.bm do |x|
  x.report do

    puts "\n---------------------------------\n\n"
    puts "Creating Director of Alignment page..."

    parent = Page.where(sluggable_field: 'work-with-learning-list').first

    dir_al = Page.create(sluggable_field: 'work-with-learning-list-director-of-alignment', title: 'Director of Alignment', parent: parent, lock: false, static: false, sortable: false, content: '
<p><strong>Job Description</strong></p>
<p>
 Based in Austin, Texas, Learning List is the industry-leading K-12 instructional materials review service for schools and districts. Our subscribing districts serve over half a million students and our library of reviews include instructional materials from over forty publishers. As one of the fastest growing companies in education, Learning List is the best combination of "Consumer Reports" and "Angie\'s List" for K-12 instructional materials.
</p>
<p><strong>Job summary:</strong><br>The Director of Alignment oversees the alignment verification process, which includes coordinating the assignment of the subject matter experts who do the alignment reports, arbitrating differences of opinion about alignment where necessary. The director works directly with Learning List\'s management team to help with marketing, business development, product, and standards research.
  </p>
<p><strong>Knowledge, skills, and experience needed for this position:  </strong><br />
<ul id="bullet-list">
<li>At least seven years of teaching experience and extensive curriculum development and alignment experience. </li>
<li>Significant experience and high comfort level working with online instructional materials. </li>
<li>Demonstrated leadership reviewing instructional materials (print and online) as part of a district, campus, or state-level selection process. </li>
<li>Experience managing multi-faceted projects.</li>
<li>Managerial experience; management of remote employees is preferred. </li>
<li>Superior organizational and interpersonal skills. </li>
<li>Very strong writing and editing skills.</li>
<li>Proficiency with Microsoft Excel and Microsoft Word to accomplish detail-oriented tasks.</li>
<li>Willingness to work in a fast-paced and evolving entrepreneurial environment.</li>
</ul></p>

<p><strong>Disclaimer</strong> <br />
The above statements are intended to describe the general nature and level of work being performed by people assigned to this classification. They are not to be construed as an exhaustive list of all responsibilities, duties, and skills required of personnel so classified. All personnel may be required to perform duties outside of their normal responsibilities from time to time, as needed.</p>

<p>
<strong>Education Qualifications:</strong>
Masters or Doctorate in Education with concentration in curriculum and instruction, Mid-Management or Principal Certification.
</p>
<p><strong>Preferred work experience:</strong><br />
Curriculum director, district and campus administration, and at least seven years of teaching experience.</p>

<p><strong>Salary:</strong><br />
Commensurate with experience. Opportunity for advancement as the company grows.
</p>
<hr />
<p><strong>Application Process:</strong><br /> Send resume and cover letter highlighting relevant work experience and qualifications for this position and three references to <a href="mailto:JackieL@LearningList.com">Jackie Lain</a>.</p>', position: 3)

    puts dir_al.inspect

    intern = Page.create(sluggable_field: 'work-with-learning-list-marketing-intern', title: 'Marketing Internship (paid)', parent: parent, lock: false, static: false, sortable: false, content: '
    <p><strong>Job Description</strong></p>
    <p>
     Based in Austin, Texas, Learning List is the industry-leading K-12 instructional materials review service for schools and districts. As one of the fastest growing companies in the education industry, Learning List is the best combination of "Consumer Reports" and "Angie\'s List" for K-12 instructional materials.
    </p>
    <p><strong>Job summary:</strong><br>The Marketing Intern will work with directly with Learning List\'s President and Vice President of Marketing, as well as other members of the management team to help with marketing, business development and product research.
      </p>
    <p><strong>Knowledge, skills, and experience needed for this position:  </strong><br />
    <ul id="bullet-list">
    <li>Passion for the field of education.</li>
    <li>Strong technology skills and the ability to work with online courses and/or instructional resources.</li>
    <li>Superior organizational skills and attention to detail.</li>
    <li>Collaborative interpersonal skills.</li>
    <li>Very strong writing/editing skills. </li>
    <li>Willingness to work in a fast-paced and evolving entrepreneurial environment.</li>
    </ul></p>

    <p><strong>Disclaimer</strong> <br />
    The above statements are intended to describe the general nature and level of work being performed by people assigned to this classification. They are not to be construed as an exhaustive list of all responsibilities, duties, and skills required of personnel so classified. All personnel may be required to perform duties outside of their normal responsibilities from time to time, as needed.</p>

    <p>
    <strong>Education Qualifications:</strong>
    Completed at least two years of college. Minimum GPA of 3.5, required.
    </p>
    <p><strong>Preferred work experience:</strong><br />
    Education, Plan II, Business, Marketing or Communications.</p>

    <p><strong>Salary:</strong><br />
    This is a paid internship with opportunity for advancement as the company grows.
    </p>
    <hr />
    <p><strong>Application Process:</strong><br /> Send resume and cover letter highlighting relevant work experience and qualifications for this position and three references to <a href="mailto:EdV@LearningList.com">Ed Valdez</a>.</p>', position: 4)

    puts intern.inspect


    puts "\n---------------------------------\n\n"
    puts "Done."
    puts "\n---------------------------------\n\n"
  end
end