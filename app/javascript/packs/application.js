import * as ActiveStorage from "activestorage";
import "../utils/direct_uploads.js"
import "../utils/text-editor.js"
import "../utils/shared.js"

import { displayLocationInfo } from 'packs/developer-form';
import { rangeDistance } from 'packs/developer-form';
import { hideRange } from 'packs/developer-form';
import { googleLocation } from 'packs/google-autocomplete';
import { rangeSalary } from 'packs/developer-form';

displayLocationInfo()
rangeDistance()
hideRange()
googleLocation()
rangeSalary()
