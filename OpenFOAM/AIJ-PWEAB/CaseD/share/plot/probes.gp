set terminal postscript eps color solid 22
set output "probes.eps"
set xlabel "Iteration number"
set ylabel "Normalized velocity" 1,0
set grid
#set key bottom
set nokey
set style data line
UH=6.61
plot \
"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($2**2+$3**2+$4**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($5**2+$6**2+$7**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($8**2+$9**2+$10**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($11**2+$12**2+$13**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($14**2+$15**2+$16**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($17**2+$18**2+$19**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($20**2+$21**2+$22**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($23**2+$24**2+$25**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($26**2+$27**2+$28**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($29**2+$30**2+$31**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($32**2+$33**2+$34**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($35**2+$36**2+$37**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($38**2+$39**2+$40**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($41**2+$42**2+$43**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($44**2+$45**2+$46**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($47**2+$48**2+$49**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($50**2+$51**2+$52**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($53**2+$54**2+$55**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($56**2+$57**2+$58**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($59**2+$60**2+$61**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($62**2+$63**2+$64**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($65**2+$66**2+$67**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($68**2+$69**2+$70**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($71**2+$72**2+$73**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($74**2+$75**2+$76**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($77**2+$78**2+$79**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($80**2+$81**2+$82**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($83**2+$84**2+$85**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($86**2+$87**2+$88**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($89**2+$90**2+$91**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($92**2+$93**2+$94**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($95**2+$96**2+$97**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($98**2+$99**2+$100**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($101**2+$102**2+$103**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($104**2+$105**2+$106**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($107**2+$108**2+$109**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($110**2+$111**2+$112**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($113**2+$114**2+$115**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($116**2+$117**2+$118**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($119**2+$120**2+$121**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($122**2+$123**2+$124**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($125**2+$126**2+$127**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($128**2+$129**2+$130**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($131**2+$132**2+$133**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($134**2+$135**2+$136**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($137**2+$138**2+$139**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($140**2+$141**2+$142**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($143**2+$144**2+$145**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($146**2+$147**2+$148**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($149**2+$150**2+$151**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($152**2+$153**2+$154**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($155**2+$156**2+$157**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($158**2+$159**2+$160**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($161**2+$162**2+$163**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($164**2+$165**2+$166**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($167**2+$168**2+$169**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($170**2+$171**2+$172**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($173**2+$174**2+$175**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($176**2+$177**2+$178**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($179**2+$180**2+$181**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($182**2+$183**2+$184**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($185**2+$186**2+$187**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($188**2+$189**2+$190**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($191**2+$192**2+$193**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($194**2+$195**2+$196**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($197**2+$198**2+$199**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($200**2+$201**2+$202**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($203**2+$204**2+$205**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($206**2+$207**2+$208**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($209**2+$210**2+$211**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($212**2+$213**2+$214**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($215**2+$216**2+$217**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($218**2+$219**2+$220**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($221**2+$222**2+$223**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($224**2+$225**2+$226**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($227**2+$228**2+$229**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($230**2+$231**2+$232**2)/UH) \
,"< sed -e 's/(//g' -e 's/)//g' postProcessing/probes/0/U" using 1:(sqrt($233**2+$234**2+$235**2)/UH) \

#    EOF
