
from pedalboard import load_plugin
plugin = load_plugin(r'C:\Users\charl\OneDrive_usp.br\Documents\Plugins\VST2-3\dearVR MICRO.vst3')
Todos_parametros = (plugin.parameters.keys())
list_of_numbers = list(range(len(Todos_parametros)))
print(' ==================================  ')
print('VST3 Index of Parameters')
for (x,y) in zip(Todos_parametros, list_of_numbers):
    print (str(y) + ' : ' + x )

