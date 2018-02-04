from django import forms
from django.core.exceptions import ValidationError

from lists.models import Item

EMPTY_ITEM_ERROR = "You can't have an empty list item"
DUPLICATE_ITEM_ERROR = "You already got this in your list"


def view_list(request, list_id):
    list_ = List.objects.get(id=list_id)
    form = ExistingListItemForm(for_list=list_)
    if request.method == 'POST':
        form = ExistingListItemForm(for_list=list_, data=request.POST)
        if form.is_valid():
            form.save()
            return redirect(list_)
    return render(request, 'list.html', {'list': list_, 'form': form})


class ItemForm(forms.models.ModelForm):
    class Meta:
        model = Item
        fields = ('text',)
        widgets = {
            'text': forms.fields.TextInput(attrs={
                'placeholder': 'Enter a to-do item',
                'class': 'form-control input-lg'
            }),
        }
        error_messages = {
            'text': {'required': EMPTY_ITEM_ERROR}
        }

    def save(self, for_list):
        self.instance.list = for_list
        return super().save()


class ExistingListItemForm(ItemForm):
    def __init__(self, for_list, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.instance.list = for_list

    def validate_unique(self):
        try:
            self.instance.validate_unique()
        except ValidationError as e:
            e.error_dict = {'text': {DUPLICATE_ITEM_ERROR}}
            self._update_errors(e)

    def save(self):
        return forms.models.ModelForm.save(self)






Error
Traceback (most recent call last):
  File "/Users/jan/projects/superlists/lists/tests/test_forms.py", line 29, in test_form_save
    new_item = form.save()
  File "/Users/jan/projects/superlists/lists/forms.py", line 42, in save
    return forms.models.ModelForm.save(self)
  File "/Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages/django/forms/models.py", line 442, in save
    if self.errors:
  File "/Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages/django/forms/forms.py", line 175, in errors
    self.full_clean()
  File "/Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages/django/forms/forms.py", line 384, in full_clean
    self._clean_fields()
  File "/Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages/django/forms/forms.py", line 396, in _clean_fields
    value = field.widget.value_from_datadict(self.data, self.files, self.add_prefix(name))
  File "/Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages/django/forms/widgets.py", line 240, in value_from_datadict
    return data.get(name)
AttributeError: 'set' object has no attribute 'get'