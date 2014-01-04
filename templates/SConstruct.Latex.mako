from SCons.Script import VariantDir, Environment, \
        Builder, Depends, Flatten
import os

VariantDir('_build', src_dir='.')

env = Environment(ENV=os.environ)
inkscape = Builder(action = 'inkscape --without-gui --export-pdf=$TARGET $SOURCE')
env['BUILDERS']['Inkscape'] = inkscape
env['BUILDERS']['Latexdiff'] = Builder(action = 'latexdiff $SOURCES > $TARGET')

svgs = [ ]

pdfs = [env.Inkscape(target="_build/" + os.path.basename(svg).replace('.svg','.pdf'), source=svg)
        for svg in svgs]

${proj}, = env.PDF(target='_build/${proj}.pdf',source='${proj}.tex')
#${proj}_supp, = env.PDF(target='_build/${proj}_supp.pdf', source='${proj}_supp.tex')
Default([${proj}])

#env.Latexdiff(target='diff.tex',source=['stored_${proj}.tex','${proj}.tex'])
#diff = env.PDF(target='diff.pdf',source='diff.tex')

Depends(Flatten([${proj}]),
        Flatten([pdfs, '${proj}.bib'])) #, 'defs.tex'

#Depends(${proj}, ${proj}_supp)

cont_build = env.Command('.continuous', ['${proj}.bib', '${proj}.tex'],
    'while :; do inotifywait -e modify $SOURCES; scons -Q; done')
Alias('continuous', cont_build)
